From: Joe Perches <joe@perches.com>
Subject: Re: [PATCH 1/4] Cleaned hexadecimal dump
Date: Sat, 07 Mar 2015 18:22:05 -0800
Message-ID: <1425781325.16901.27.camel@perches.com>
References: <1425750995-18176-1-git-send-email-adrianremonda@gmail.com>
	 <1425750995-18176-2-git-send-email-adrianremonda@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Cc: broonie@kernel.org, corbet@lwn.net, linux-spi@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
To: Adrian Remonda <adrianremonda@gmail.com>
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <1425750995-18176-2-git-send-email-adrianremonda@gmail.com>
Sender: linux-doc-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Sat, 2015-03-07 at 12:56 -0500, Adrian Remonda wrote:
> Signed-off-by: Adrian Remonda <adrianremonda@gmail.com>
[]
> diff --git a/Documentation/spi/spidev_test.c b/Documentation/spi/spidev_test.c
[]
> +static void hexDump(const void *src, size_t length, size_t bLine, char *prefix)
> +{

Is there something necessary that print_hex_dump can't do?

> +	int i = 0;
> +	char *address = (char *)src;
> +	char *line = (char *)address;
> +	unsigned char c;
> +
> +	printf("%s | ", prefix);
> +	while (length-- > 0) {
> +		printf("%02X ", (unsigned char)*address++);
> +		if (!(++i % bLine) || (length == 0 && i % bLine)) {
> +			if (length == 0) {
> +				while (i++ % bLine)
> +					printf("__ ");
> +			}
> +			printf(" | ");  /* right close */
> +			while (line < address) {
> +				c = *line++;
> +				printf("%c", (c < 33 || c == 255) ? 0x2E : c);
> +			}
> +			printf("\n");
> +			if (length > 0)
> +				printf("%s | ", prefix);
> +		}
> +	}
> +}



