% Đọc dữ liệu từ file CSV
data = readmatrix('1mV.csv');
x = data(:, 4); % Trích xuất cột thứ 4

% Tham số bộ lọc FIR với cửa sổ Kaiser
f_low = 0.95e6;       % Tần số cắt thấp
f_high = 1.05e6;      % Tần số cắt cao
fs = 100e6;            % Tần số lấy mẫu
N = 240;                 % Bậc của bộ lọc FIR
beta = 10;            % Tham số cửa sổ Kaiser (có thể điều chỉnh)

% Chuẩn hóa tần số cắt
Wn = [f_low f_high] / (fs / 2);

% Thiết kế bộ lọc FIR thông dải với cửa sổ Kaiser
b = fir1(N, Wn, 'bandpass', kaiser(N+1, beta));

% Áp dụng bộ lọc FIR lên dữ liệu và điều chỉnh hệ số
y = filter(b, 1, x) * 29000 / 2^12;

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
