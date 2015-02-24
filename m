From: Axel Lin <axel.lin@ingics.com>
Subject: Re: [PATCH v1 1/1] spi: dw: revisit FIFO size detection again
Date: Wed, 25 Feb 2015 07:45:16 +0800
Message-ID: <CAFRkauC4KuNpx08u0GJEEY68GTwFo3oskN0sfEoZLt4_z1FVmQ@mail.gmail.com>
References: <1424803388-6033-1-git-send-email-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Mark Brown <broonie@kernel.org>,
	linux-spi <linux-spi@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <1424803388-6033-1-git-send-email-andriy.shevchenko@linux.intel.com>
Sender: stable-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

2015-02-25 2:43 GMT+08:00 Andy Shevchenko <andriy.shevchenko@linux.intel.com>:
> The commit d297933cc7fc (spi: dw: Fix detecting FIFO depth) tries to fix the
> logic of the FIFO detection based on the description on the comments. However,
> there is a slight difference between numbers in TX Level and TX FIFO size.
>
> So, by specification the FIFO size would be in a range 2-256 bytes. From TX
> Level prospective it means we can set threshold in the range 0-(FIFO size - 1)
> bytes. Hence there are currently two issues:
>   a) FIFO size 2 bytes is actually skipped since TX Level is 1 bit and could be
>      either 0 or 1 byte;
>   b) FIFO size is incorrectly decreased by 1 which already done by meaning of
>      TX Level register.
>
> This patch fixes it eventually right.
>
> Fixes: d297933cc7fc (spi: dw: Fix detecting FIFO depth)
> Cc: Axel Lin <axel.lin@ingics.com>
> Cc: stable@vger.kernel.org
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Reviewed-by: Axel Lin <axel.lin@ingics.com>
