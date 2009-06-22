From: Baruch Siach <baruch@tkos.co.il>
Subject: Re: [spi-devel-general] [PATCH] SST25L (non JEDEC) SPI Flash driver
Date: Mon, 22 Jun 2009 07:14:57 +0300
Message-ID: <20090622041457.GC6027@tarshish>
References: <4A3F017B.2010409@bluewatersys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Woodhouse <dwmw2@infradead.org>,
	linux-mtd@lists.infradead.org,
	spi-devel-general@lists.sourceforge.net, mike@steroidmicros.com,
	linux kernel <linux-kernel@vger.kernel.org>
To: Ryan Mallon <ryan@bluewatersys.com>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1752851AbZFVEQB@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <4A3F017B.2010409@bluewatersys.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hi Ryan,

On Mon, Jun 22, 2009 at 03:58:51PM +1200, Ryan Mallon wrote:
> +static int sst25l_erase_block(struct sst25l_flash *flash, u32 offset)
> +{
> +	u8 command[4];
> +	int err;
> +
> +	err = sst25l_write_enable(flash, 1);

Is this enable/disable strictly required for each write/erase? Can't we just 
enable write once?

> +	if (err)
> +		return err;
> +
> +	command[0] = SST25L_CMD_BLOCK_ERASE;
> +	command[1] = offset >> 16;
> +	command[2] = offset >> 8;
> +	command[3] = offset;
> +	err = spi_write(flash->spi, command, 4);
> +	if (err)
> +		return err;
> +
> +	err = sst25l_wait_till_ready(flash);
> +	if (err)
> +		return err;
> +
> +	return sst25l_write_enable(flash, 0);
> +}

baruch

-- 
                                                     ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch@tkos.co.il - tel: +972.2.679.5364, http://www.tkos.co.il -
