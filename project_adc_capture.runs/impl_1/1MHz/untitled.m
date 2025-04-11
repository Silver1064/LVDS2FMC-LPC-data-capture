% Đọc dữ liệu từ file CSV
data = readmatrix('1V.csv');

% Lấy cột đầu tiên của dữ liệu
x = data(:, 4); % Trích xuất cột đầu tiên

% Tham số bộ lọc
f_low = 0.995e6;       % Tần số cắt thấp
f_high = 1.005e6;      % Tần số cắt cao
fs = 100e6;            % Tần số lấy mẫu
n = 3;                 % Bậc của bộ lọc

% Chuẩn hóa tần số cắt
Wn = [f_low f_high] / (fs / 2);

% Thiết kế bộ lọc Butterworth thông dải
[b, a] = butter(n, Wn, 'bandpass');

% Áp dụng bộ lọc thông dải lên dữ liệu và điều chỉnh hệ số
y = filter(b, a, x);

% Ghi tín hiệu đã lọc ra file Excel
output_filename = 'filtered_signal_1MHz_10_to_100.xlsx';
writematrix(y, output_filename, 'Sheet', 2, 'Range', 's2');
disp(['Tín hiệu đã lọc đã được ghi ra file ', output_filename]);

% Tính FFT cho tín hiệu gốc
N = length(x);
X_fft = fft(x);
X_mag = abs(X_fft/N);          % Độ lớn của FFT
f = (0:N-1)*(fs/N);            % Tần số tương ứng

% Tính FFT cho tín hiệu sau khi lọc
Y_fft = fft(y);
Y_mag = abs(Y_fft/N);          % Độ lớn của FFT

% Vẽ đồ thị tín hiệu trước và sau khi lọc trong miền thời gian
figure;
subplot(2,1,1);
plot(x);
title('Tín hiệu gốc trong miền thời gian');
xlabel('Thời gian');
ylabel('Biên độ');

subplot(2,1,2);
plot(y);
title('Tín hiệu sau khi lọc trong miền thời gian');
xlabel('Thời gian');
ylabel('Biên độ');

% Vẽ phổ FFT của tín hiệu trước và sau khi lọc
figure;
subplot(2,1,1);
plot(f(1:N/2), X_mag(1:N/2)); % Chỉ vẽ nửa phổ do tính đối xứng
title('Phổ FFT của tín hiệu gốc');
xlabel('Tần số (Hz)');
ylabel('Biên độ');

subplot(2,1,2);
plot(f(1:N/2), Y_mag(1:N/2)); % Chỉ vẽ nửa phổ do tính đối xứng
title('Phổ FFT của tín hiệu sau khi lọc');
xlabel('Tần số (Hz)');
ylabel('Biên độ');
