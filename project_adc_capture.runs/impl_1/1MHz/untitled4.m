% % Các tham số
% Fs = 100e6;       % Tần số lấy mẫu (100 MHz)
% f_low = 0.95e6;   % Tần số cắt thấp (0.95 MHz)
% f_high = 1.01e6;  % Tần số cắt cao (1.01 MHz)
% order = 3;        % Bậc của bộ lọc
% 
% % Chuẩn hóa tần số cắt
% Wn = [f_low, f_high] / (Fs / 2);
% 
% % Thiết kế bộ lọc Butterworth băng thông
% [b, a] = butter(order, Wn, 'bandpass');
% 
% % Vẽ biểu đồ Bode
% figure;
% bode(b, a);
% grid on;
% title('Biểu đồ Bode của bộ lọc Butterworth băng thông bậc 3 (Fs = 100 MHz)');


% Các tham số
f_low = 0.995e6;       % Tần số cắt thấp
f_high = 1.005e6;      % Tần số cắt cao
fs = 100e6;            % Tần số lấy mẫu
n = 3;                 % Bậc của bộ lọc

% Chuẩn hóa tần số cắt
Wn = [f_low, f_high] / (Fs / 2);

% Thiết kế bộ lọc Butterworth băng thông
[b, a] = butter(order, Wn, 'bandpass');

% Đọc dữ liệu đầu vào từ file CSV
data = readmatrix('1mv.csv');  % Giả sử dữ liệu nằm ở cột A

% Lấy tín hiệu đầu vào từ cột đầu tiên
input_signal = data(:, 4);  % Nếu dữ liệu trong cột A

% Áp dụng bộ lọc vào tín hiệu đầu vào
output_signal = filter(b, a, input_signal);

% Vẽ đồ thị FFT của tín hiệu trước khi lọc
N = length(input_signal);  % Số mẫu
f = (0:N-1)*(Fs/N);        % Trục tần số

% FFT của tín hiệu đầu vào
input_fft = abs(fft(input_signal));

% FFT của tín hiệu sau khi lọc
output_fft = abs(fft(output_signal));

% Vẽ đồ thị FFT
figure;
subplot(2, 1, 1);
plot(f, 20*log10(input_fft));  % Biểu đồ FFT của tín hiệu đầu vào
title('FFT của tín hiệu đầu vào');
xlabel('Tần số (Hz)');
ylabel('Biên độ (dB)');
xlim([0 Fs/2]);  % Giới hạn tần số từ 0 đến Nyquist

subplot(2, 1, 2);
plot(f, 20*log10(output_fft));  % Biểu đồ FFT của tín hiệu sau khi lọc
title('FFT của tín hiệu sau khi lọc');
xlabel('Tần số (Hz)');
ylabel('Biên độ (dB)');
xlim([0 Fs/2]);  % Giới hạn tần số từ 0 đến Nyquist

% Vẽ tín hiệu đầu vào và sau khi lọc
figure;
subplot(2, 1, 1);
plot(input_signal);
title('Tín hiệu đầu vào');
xlabel('Thời gian (mẫu)');
ylabel('Biên độ');

subplot(2, 1, 2);
plot(output_signal);
title('Tín hiệu sau khi lọc');
xlabel('Thời gian (mẫu)');
ylabel('Biên độ');
