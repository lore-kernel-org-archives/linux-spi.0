From: Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: [PATCH 2/2] spi: convert drivers to use bits_per_word_mask
Date: Tue, 09 Jul 2013 09:50:45 -0600
Message-ID: <51DC3155.7020709@wwwdotorg.org>
References: <1369190195-14598-1-git-send-email-swarren@wwwdotorg.org> <1369190195-14598-2-git-send-email-swarren@wwwdotorg.org> <51DC3078.5090602@monstr.eu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Mark Brown <broonie@kernel.org>,
	Grant Likely <grant.likely@linaro.org>,
	spi-devel-general@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	device-drivers-devel@blackfin.uclinux.org,
	Mike Frysinger <vapier@gentoo.org>
To: monstr@monstr.eu
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <51DC3078.5090602@monstr.eu>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On 07/09/2013 09:47 AM, Michal Simek wrote:
>> diff --git a/drivers/spi/spi-xilinx.c b/drivers/spi/spi-xilinx.c 
>> index e1d7696..f321bf9 100644 --- a/drivers/spi/spi-xilinx.c +++
>> b/drivers/spi/spi-xilinx.c @@ -232,21 +232,6 @@ static int
>> xilinx_spi_setup_transfer(struct spi_device *spi, return 0; }
>> 
>> -static int xilinx_spi_setup(struct spi_device *spi) -{ -	/*
>> always return 0, we can not check the number of bits. -	 * There
>> are cases when SPI setup is called before any driver is -	 *
>> there, in that case the SPI core defaults to 8 bits, which we -
>> * do not support in some cases. But if we return an error, the -
>> * SPI device would not be registered and no driver can get hold
>> of it -	 * When the driver is there, it will call SPI setup again
>> with the -	 * correct number of bits per transfer. -	 * If a
>> driver setups with the wrong bit number, it will fail when -	 *
>> it tries to do a transfer -	 */ -	return 0; -} - static void
>> xilinx_spi_fill_tx_fifo(struct xilinx_spi *xspi) { u8 sr; @@
>> -377,7 +362,6 @@ struct spi_master *xilinx_spi_init(struct device
>> *dev, struct resource *mem, xspi->bitbang.chipselect =
>> xilinx_spi_chipselect; xspi->bitbang.setup_transfer =
>> xilinx_spi_setup_transfer; xspi->bitbang.txrx_bufs =
>> xilinx_spi_txrx_bufs; -	xspi->bitbang.master->setup =
>> xilinx_spi_setup; init_completion(&xspi->done);
>> 
>> if (!request_mem_region(mem->start, resource_size(mem),
>> 
> 
> This part of this patch is breaking xilinx spi driver because when 
> spi_bitbang_start is called it goes through some if else... and
> because bitbang->txrx_bufs is defined it end up in this code } else
> if (!master->setup) { return -EINVAL; }
> 
> Probably the best solution is just revert this part of patch. Mark:
> What do you think?

Hmm. Why is master->setup required by the bitbang driver, if it's
legal (i.e. the code works) to implement it just by doing nothing?
