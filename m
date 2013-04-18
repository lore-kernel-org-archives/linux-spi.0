From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] spi/s3c64xx: Fix non-dmaengine usage
Date: Thu, 18 Apr 2013 19:33:21 +0200
Message-ID: <201304181933.21598.arnd@arndb.de>
References: <1366304814-19428-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Cc: Grant Likely <grant.likely@linaro.org>,
	linux-kernel@vger.kernel.org,
	spi-devel-general@lists.sourceforge.net
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1366304814-19428-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Thursday 18 April 2013, Mark Brown wrote:
> The multiplatform conversion in commit 788437 (spi: s3c64xx: move to
> generic dmaengine API) tested for the use of the Samsung-specific DMA
> API with SAMSUNG_DMADEV when in fact S3C_DMA should be used. This
> renderd DMA based transfers non-functional on platforms not using
> dmaengine.
> 
> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>

Acked-by: Arnd Bergmann <arnd@arndb.de>

Sorry for the confusion on my part. I thought that S3C_DMA was referring
to just the S3C specific functionality while SAMSUNG_DMADEV was the
wrapper around it, while in truth SAMSUNG_DMADEV is the wrapper around
just the dmaengine API.

	Arnd
