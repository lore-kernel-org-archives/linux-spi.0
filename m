From: Jassi Brar <jassisinghbrar@gmail.com>
Subject: Re: [spi-devel-general] [PATCH 1/2] spi/spi_s3c64xx: Make probe more
 robust against missing board config
Date: Sat, 21 Aug 2010 10:45:56 +0900
Message-ID: <AANLkTimggbZqgv=eKe+wx8YvUX5vOppDfmwpLwTgxJFM@mail.gmail.com>
References: <1282321028-32196-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: David Brownell <dbrownell@users.sourceforge.net>,
	Grant Likely <grant.likely@secretlab.ca>,
	spi-devel-general@lists.sourceforge.net,
	linux-kernel@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1282321028-32196-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Sat, Aug 21, 2010 at 1:17 AM, Mark Brown
<broonie@opensource.wolfsonmicro.com> wrote:
> The S3C64xx SPI driver requires the machine to call s3c64xx_spi_set_info()
> to select a few options, including the clock to use for the SPI controller.
> If this is not done then a NULL will be passed as the clock name for
> clk_get(), causing an obscure crash. Guard against this and other missing
> configuration by validating that the clock name has been filled in in
> the platform data that ets passed in.

     The movement of sci assignment and check doesn't make any
difference because
      we already check for presence of platform_data and DMA-Tx,Rx and
IO base is
      set irrespective of calling s3c64xx_spi_set_info()

    Also, I think !sci->num_cs might be an even better check because
the samsung clock
   api might be changed (IIRC Ben was already working it out) to make
it redundant
   to pass clock name strings to clk_get. If that is the case, we might end up
   adding another foolproof check like !sci->num_cs

    what do you guys think?

regards
