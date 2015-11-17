From: Anton Bondarenko <anton.bondarenko.sama@gmail.com>
Subject: Re: [PATCH 3/8] Documentation/spi/spidev_test.c: accept input from a
 file
Date: Tue, 17 Nov 2015 19:26:54 +0100
Message-ID: <564B716E.5020605@gmail.com>
References: <cover.1447773299.git.stillcompiling@gmail.com>
 <d90d749776cf562bc9922aff5e97cb911a77b22b.1447773299.git.stillcompiling@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Jonathan Corbet <corbet@lwn.net>,
	Adrian Remonda <adrianremonda@gmail.com>,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-spi@vger.kernel.org
To: Joshua Clayton <stillcompiling@gmail.com>,
	Mark Brown <broonie@kernel.org>
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <d90d749776cf562bc9922aff5e97cb911a77b22b.1447773299.git.stillcompiling@gmail.com>
Sender: linux-doc-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On 17.11.2015 16:24, Joshua Clayton wrote:
> Add input file support to facilitate testing larger data.
>
> Signed-off-by: Joshua Clayton <stillcompiling@gmail.com>
> ---
>   Documentation/spi/spidev_test.c | 42 ++++++++++++++++++++++++++++++++++++++++-
>   1 file changed, 41 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/spi/spidev_test.c b/Documentation/spi/spidev_test.c
> index 1ed9110..ef812ad 100644
> --- a/Documentation/spi/spidev_test.c
> +++ b/Documentation/spi/spidev_test.c
> @@ -19,6 +19,7 @@
>   #include <getopt.h>
>   #include <fcntl.h>
>   #include <sys/ioctl.h>
> +#include <sys/stat.h>
>   #include <linux/types.h>
>   #include <linux/spi/spidev.h>
>
> @@ -33,6 +34,7 @@ static void pabort(const char *s)
>   static const char *device = "/dev/spidev1.1";
>   static uint32_t mode;
>   static uint8_t bits = 8;
> +static char *input_file;
>   static uint32_t speed = 500000;
>   static uint16_t delay;
>   static int verbose;
> @@ -144,6 +146,7 @@ static void print_usage(const char *prog)
>   	     "  -s --speed    max speed (Hz)\n"
>   	     "  -d --delay    delay (usec)\n"
>   	     "  -b --bpw      bits per word \n"
> +	     "  -i --input    input data from a file (e.g. \"test.bin\")\n"
>   	     "  -l --loop     loopback\n"
>   	     "  -H --cpha     clock phase\n"
>   	     "  -O --cpol     clock polarity\n"
> @@ -167,6 +170,7 @@ static void parse_opts(int argc, char *argv[])
>   			{ "speed",   1, 0, 's' },
>   			{ "delay",   1, 0, 'd' },
>   			{ "bpw",     1, 0, 'b' },
> +			{ "input",   1, 0, 'i' },
>   			{ "loop",    0, 0, 'l' },
>   			{ "cpha",    0, 0, 'H' },
>   			{ "cpol",    0, 0, 'O' },
> @@ -182,7 +186,8 @@ static void parse_opts(int argc, char *argv[])
>   		};
>   		int c;
>
> -		c = getopt_long(argc, argv, "D:s:d:b:lHOLC3NR24p:v", lopts, NULL);
> +		c = getopt_long(argc, argv, "D:s:d:b:i:lHOLC3NR24p:v",
> +				lopts, NULL);
>
>   		if (c == -1)
>   			break;
> @@ -200,6 +205,9 @@ static void parse_opts(int argc, char *argv[])
>   		case 'b':
>   			bits = atoi(optarg);
>   			break;
> +		case 'i':
> +			input_file = optarg;
> +			break;
>   		case 'l':
>   			mode |= SPI_LOOP;
>   			break;
> @@ -259,6 +267,33 @@ static void transfer_escaped_string(int fd, char *str)
>   	free(tx);
>   }
>
> +static void transfer_file(int fd, char *filename)
> +{
> +	ssize_t bytes;
> +	struct stat sb;
> +	int tx_fd;
> +	uint8_t *tx;
> +
> +	if (stat(filename, &sb) == -1)
> +		pabort("can't stat input file");
> +
> +	if (sb.st_size > 4096)
> +		pabort("input file exceeds spidev's 4k limit");
This is not a true. IIRC PAGE_SIZE is the default buffer size for 
spidev, but can be changed using bufsiz module parameter.
Just 'insmod spidev bufsiz=X', where X is number of bytes.
> +
> +	tx_fd = open(filename, O_RDONLY);
> +	if (fd < 0)
> +		pabort("can't open input file");
> +
> +	tx = malloc(sb.st_size);
It would be good to check new allocations for fail.
> +	bytes = read(tx_fd, tx, sb.st_size);
> +	if (bytes != sb.st_size)
> +		pabort("failed to read input file");
> +
> +	transfer(fd, tx, sb.st_size);
> +	free(tx);
> +	close(tx_fd);
> +}
> +
>   int main(int argc, char *argv[])
>   {
>   	int ret = 0;
> @@ -307,8 +342,13 @@ int main(int argc, char *argv[])
>   	printf("bits per word: %d\n", bits);
>   	printf("max speed: %d Hz (%d KHz)\n", speed, speed/1000);
>
> +	if (input_tx && input_file)
> +		pabort("only one of -p and --input may be selected");
> +
>   	if (input_tx)
>   		transfer_escaped_string(fd, input_tx);
> +	else if (input_file)
> +		transfer_file(fd, input_file);
>   	else
>   		transfer(fd, default_tx, sizeof(default_tx));
>
>
