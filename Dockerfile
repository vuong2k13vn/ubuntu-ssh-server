FROM ubuntu:22.04

# Cập nhật và cài SSH
RUN apt update && apt install -y openssh-server sudo

# Tạo user tên 'ubuntu' với quyền root
RUN useradd -m ubuntu && echo "ubuntu:123456" | chpasswd && adduser ubuntu sudo

# Cho phép đăng nhập SSH bằng mật khẩu
RUN mkdir /var/run/sshd
RUN sed -i 's/#PasswordAuthentication yes/PasswordAuthentication yes/' /etc/ssh/sshd_config
RUN sed -i 's/PasswordAuthentication no/PasswordAuthentication yes/' /etc/ssh/sshd_config
RUN echo "PermitRootLogin yes" >> /etc/ssh/sshd_config

# Mở cổng SSH
EXPOSE 22

# Chạy SSH khi khởi động container
CMD ["/usr/sbin/sshd", "-D"]
