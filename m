From: Brian Norris <computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] Check flag status register for Micron n25q512a
Date: Wed, 26 Feb 2014 23:33:14 -0800
Message-ID: <20140227073314.GD13420@norris-Latitude-E6410>
References: <6bf927e513554e628fe15d309aac698e@BLUPR07MB002.namprd07.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	"linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
	"Priyanka.Jain-KZfg59tc24xl57MIdRCFDg@public.gmane.org" <Priyanka.Jain-KZfg59tc24xl57MIdRCFDg@public.gmane.org>,
	Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>
To: Insop Song <Insop.Song-X7+3OicCfH32eFz/2MeuCQ@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <6bf927e513554e628fe15d309aac698e-rlQrbxGbpbNDMtzC+POkThQPvRvOrrxkXA4E9RH9d+qIuWR1G4zioA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

+ Marek

Hi Insop, 

On Mon, Jan 06, 2014 at 05:21:17AM +0000, Insop Song wrote:
> In order to use Micron n25q512a, MTD, two changes are required as follows:
> - jedec code should be fixed

I have a feeling there are more than one "n25q512a" device, with
different IDs.

> - flag status should be read for writing.
> 
> Check flag status register for Micron n25q512a
>     - Programing Micron n25q512a requires to check flag status register
>     - According to datasheet
>     	"
>     	The flag status register must be read any time a PROGRAM, ERASE,
>     	SUSPEND/RESUME command is issued, or after a RESET command while device
>     	is busy. The cycle is not complete until bit 7 of the flag status
>     	register output 1.
>     	"
>     - Ref: https://www.micron.com/~/media/Documents/Products/Data%20Sheet/NOR%20Flash/Serial%20NOR/N25Q/n25q_512mb_1ce_3v_65nm.pdf

Hmm, are you sure that all Micron n25q512a need to check the flag status
register? I'll check my datasheets when I'm back in the office, but this
seems peculiar.
 
> Signed-off-by: Insop Song <insop.song-X7+3OicCfH32eFz/2MeuCQ@public.gmane.org>
> ---
>  drivers/mtd/devices/m25p80.c |   91 +++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 90 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mtd/devices/m25p80.c b/drivers/mtd/devices/m25p80.c
> index 7eda71d..e53e522 100644
> --- a/drivers/mtd/devices/m25p80.c
> +++ b/drivers/mtd/devices/m25p80.c
> @@ -38,6 +38,7 @@
>  /* Flash opcodes. */
>  #define	OPCODE_WREN		0x06	/* Write enable */
>  #define	OPCODE_RDSR		0x05	/* Read status register */
> +#define	OPCODE_RDFSR		0x70	/* Read flag status register */
>  #define	OPCODE_WRSR		0x01	/* Write status register 1 byte */
>  #define	OPCODE_NORM_READ	0x03	/* Read data bytes (low frequency) */
>  #define	OPCODE_FAST_READ	0x0b	/* Read data bytes (high frequency) */
> @@ -70,6 +71,8 @@
>  /* Status Register bits. */
>  #define	SR_WIP			1	/* Write in progress */
>  #define	SR_WEL			2	/* Write enable latch */
> +/* Flag Status Register bits. */
> +#define	FSR_RDY			0x80	/* FSR ready */
>  /* meaning of other SR_* bits may differ between vendors */
>  #define	SR_BP0			4	/* Block protect 0 */
>  #define	SR_BP1			8	/* Block protect 1 */
> @@ -95,6 +98,7 @@ struct m25p {
>  	u8			program_opcode;
>  	u8			*command;
>  	bool			fast_read;
> +	bool			flag_status;
>  };
>  
>  static inline struct m25p *mtd_to_m25p(struct mtd_info *mtd)
> @@ -131,6 +135,28 @@ static int read_sr(struct m25p *flash)
>  }
>  
>  /*
> + * Read the flag status register, returning its value in the location
> + * Return the status register value.
> + * Returns negative if error occurred.
> + */
> +static int read_fsr(struct m25p *flash)
> +{
> +	ssize_t retval;
> +	u8 code = OPCODE_RDFSR;
> +	u8 val;
> +
> +	retval = spi_write_then_read(flash->spi, &code, 1, &val, 1);
> +
> +	if (retval < 0) {
> +		printk(&flash->spi->dev, "error %d reading FSR\n",
> +				(int) retval);
> +		return retval;
> +	}
> +
> +	return val;
> +}
> +
> +/*
>   * Write status register 1 byte
>   * Returns negative if error occurred.
>   */
> @@ -220,6 +246,30 @@ static int wait_till_ready(struct m25p *flash)
>  }
>  
>  /*
> + * Service routine to read flag status register until ready, or timeout occurs.
> + * Returns non-zero if error.
> + */
> +static int wait_till_fsr_ready(struct m25p *flash)
> +{
> +	unsigned long deadline;
> +	int sr;
> +
> +	deadline = jiffies + MAX_READY_WAIT_JIFFIES;
> +
> +	do {
> +		if ((sr = read_fsr(flash)) < 0)
> +			break;
> +		else if ((sr & FSR_RDY))
> +			return 0;
> +
> +		cond_resched();
> +
> +	} while (!time_after_eq(jiffies, deadline));
> +
> +	return 1;
> +}
> +
> +/*
>   * Erase the whole flash memory
>   *
>   * Returns 0 if successful, non-zero otherwise.
> @@ -273,6 +323,14 @@ static int erase_sector(struct m25p *flash, u32 offset)
>  	if (wait_till_ready(flash))
>  		return 1;
>  
> +	/* Flag status, Wait until finished previous write command. */
> +	if (flash->flag_status == true) {
> +		if (wait_till_fsr_ready(flash)) {
> +			mutex_unlock(&flash->lock);
> +			return 1;
> +		}
> +	}
> +
>  	/* Send write enable, then erase commands. */
>  	write_enable(flash);
>  
> @@ -427,6 +485,14 @@ static int m25p80_write(struct mtd_info *mtd, loff_t to, size_t len,
>  
>  	mutex_lock(&flash->lock);
>  
> +	/* Flag status, Wait until finished previous write command. */
> +	if (flash->flag_status == true) {
> +		if (wait_till_fsr_ready(flash)) {
> +			mutex_unlock(&flash->lock);
> +			return 1;
> +		}
> +	}
> +
>  	/* Wait until finished previous write command. */
>  	if (wait_till_ready(flash)) {
>  		mutex_unlock(&flash->lock);
> @@ -457,6 +523,14 @@ static int m25p80_write(struct mtd_info *mtd, loff_t to, size_t len,
>  		t[1].len = page_size;
>  		spi_sync(flash->spi, &m);
>  
> +		/* Flag status, Wait until finished previous write command. */
> +		if (flash->flag_status == true) {
> +			if (wait_till_fsr_ready(flash)) {
> +				mutex_unlock(&flash->lock);
> +				return 1;
> +			}
> +		}
> +
>  		*retlen = m.actual_length - m25p_cmdsz(flash);
>  
>  		/* write everything in flash->page_size chunks */
> @@ -477,6 +551,14 @@ static int m25p80_write(struct mtd_info *mtd, loff_t to, size_t len,
>  
>  			spi_sync(flash->spi, &m);
>  
> +			/* Flag status, Wait until finished previous write command. */
> +			if (flash->flag_status == true) {
> +				if (wait_till_fsr_ready(flash)) {
> +					mutex_unlock(&flash->lock);
> +					return 1;
> +				}
> +			}
> +
>  			*retlen += m.actual_length - m25p_cmdsz(flash);
>  		}
>  	}
> @@ -782,7 +864,7 @@ static const struct spi_device_id m25p_ids[] = {
>  	{ "n25q128a11",  INFO(0x20bb18, 0, 64 * 1024,  256, 0) },
>  	{ "n25q128a13",  INFO(0x20ba18, 0, 64 * 1024,  256, 0) },
>  	{ "n25q256a",    INFO(0x20ba19, 0, 64 * 1024,  512, SECT_4K) },
> -	{ "n25q512a",    INFO(0x20bb20, 0, 64 * 1024, 1024, SECT_4K) },
> +	{ "n25q512a",    INFO(0x20ba20, 0, 64 * 1024, 1024, SECT_4K) },

You probably want to figure out the distinction between the old table
entry and the new one, and assign your new entry a new string
accordingly.

>  
>  	/* PMC */
>  	{ "pm25lv512",   INFO(0,        0, 32 * 1024,    2, SECT_4K_PMC) },
> @@ -996,6 +1078,13 @@ static int m25p_probe(struct spi_device *spi)
>  	spi_set_drvdata(spi, flash);
>  
>  	/*
> +	 * Micron n25q512a requires to check flag status register
> +	 */
> +	flash->flag_status = false;
> +	if (strcmp(id->name, "n25q512a") == 0)
> +		flash->flag_status = true;;

This doesn't look good at all. If any other flash start to need this, we
don't want to code each ID string here. That's fragile and
non-scaleable. If we need this option, you need to add another flag to
the m25p_ids[] table, I guess...

> +
> +	/*
>  	 * Atmel, SST and Intel/Numonyx serial flash tend to power
>  	 * up with the software protection bits set
>  	 */

Brian
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
