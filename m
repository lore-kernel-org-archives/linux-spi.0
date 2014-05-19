From: "Ivan T. Ivanov" <iivanov@mm-sol.com>
Subject: Re: [PATCH 1/4] spi: qup: Remove chip select function
Date: Mon, 19 May 2014 11:07:38 +0300
Message-ID: <1400486858.1464.11.camel@iivanov-dev>
References: <1400016884-9568-1-git-send-email-agross@codeaurora.org>
	 <1400016884-9568-2-git-send-email-agross@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Bjorn Andersson <bjorn.andersson@sonymobile.com>
To: Andy Gross <agross@codeaurora.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1400016884-9568-2-git-send-email-agross@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


Hi Andy,

On Tue, 2014-05-13 at 16:34 -0500, Andy Gross wrote:
> This patch removes the chip select function.  Chip select should instead be
> supported using GPIOs, defining the DT entry "cs-gpios", and letting the SPI
> core assert/deassert the chip select as it sees fit.
> 
> Signed-off-by: Andy Gross <agross@codeaurora.org>

<snip>

> +- num-cs:	total number of chipselects

My understanding is that "num-cs" have to be parsed by
master driver, not by core SPI driver.

> -
> -	/* Disable auto CS toggle and use manual */
> -	iocontol &= ~SPI_IO_C_MX_CS_MODE;

Probably we should keep this?

Regards,
Ivan
