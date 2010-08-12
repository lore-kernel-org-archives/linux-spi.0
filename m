From: Erik Gilling <konkers-z5hGa2qSFaRBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH] spi: add spi_tegra driver
Date: Wed, 11 Aug 2010 17:31:00 -0700
Message-ID: <AANLkTinKNfPtaYYyUMmdTRewSKiRnTEfaf+pKkx_7jME@mail.gmail.com>
References: <1280450224-25118-1-git-send-email-ccross@google.com>
	<AANLkTimUm_wj+gyxTa=X+845kLj1sZ9GF+jsmsBwxnLN@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Cc: linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Colin Cross <ccross-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>
To: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <AANLkTimUm_wj+gyxTa=X+845kLj1sZ9GF+jsmsBwxnLN-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Sat, Jul 31, 2010 at 11:21 PM, Grant Likely
<grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org> wrote:
> What is the status of the APB DMA driver? =A0Is it going to be merged in =
2.6.36?

Since we were too late on these patches, they will go into the 37
merge window.  The APB DMA driver will go in then along with SPI.

>> + * drivers/spi/spi_tegra.c
>
> I find it is more useful, and it is my preference, to have a one-line
> description of what the file actually is here. =A0Showing the filename
> is just redundant and doesn't tell a reader anything new.

I'll change it so it matches the rest of the files in the directory

>> +#define DRIVER_NAME =A0 =A0 =A0 =A0 =A0 =A0"spi_tegra"
>
> Used only twice in 2 side-by-side locations. =A0I'd trim, or at least
> move to where it is actually used.

done


>> +#define BUSY_TIMEOUT =A0 =A0 =A0 =A0 =A0 1000
>
> Used exactly once. =A0May be better defined and documented at the usage s=
ite

done

>> +
>> +static inline unsigned bytes_per_word(u8 bits)
>> +{
>> + =A0 =A0 =A0 WARN_ON((bits < 1) || bits > 32);
>
> This condition has already been tested for in spi_tegra_start_transfer()
>
>> + =A0 =A0 =A0 if (bits <=3D 8)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 1;
>> + =A0 =A0 =A0 else if (bits <=3D 16)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 2;
>> + =A0 =A0 =A0 else if (bits <=3D 24)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 3;
>> + =A0 =A0 =A0 else
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 4;
>
> return ((bits - 1) / 8) + 1
>
> Also, this function is used in exactly 1 place. =A0Consider moving it
> down to nearer where it is called, or open coding it instead.

moved to spi_tegra_start_transfer

>> +static unsigned long spi_readl(struct spi_tegra_data *tspi, unsigned lo=
ng reg)
>
> To avoid global namespace collisions, please prefix all static symbols
> with something like tegra_spi_.

changed

>> +{
>> + =A0 =A0 =A0 return readl(tspi->base + reg);
>> +}
>> +
>> +static void spi_writel(struct spi_tegra_data *tspi, unsigned long val,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0unsigned long reg)
>> +{
>> + =A0 =A0 =A0 writel(val, tspi->base + reg);
>> +}
>
> Are the accessor redirects really necessary? =A0Is there any likelyhood
> that anything other than readl/writel will ever be used to access the
> device regs?

They are there to make reset of the code easier to read and less error
probe by eliminating the tspi->base + reg from every call.

>> +
>> + =A0 =A0 =A0 speed =3D t->speed_hz ? t->speed_hz : spi->max_speed_hz;
>> + =A0 =A0 =A0 bits_per_word =3D t->bits_per_word ? t->bits_per_word =A0:
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 spi->bits_per_word;
>> +
>> + =A0 =A0 =A0 if (bits_per_word < 1 || bits_per_word > 32)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
>> +
>> + =A0 =A0 =A0 if (t->len =3D=3D 0)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
>> +
>> + =A0 =A0 =A0 if (!t->rx_buf && !t->tx_buf)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
>
> Looks to me like this validation should be performed before accepting
> the transfer (see comments below)

moved


>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 tspi->cur =3D =A0list_first_entry(&tspi->c=
ur->transfer_list,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 struct spi_transfer,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 transfer_list);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 spi_tegra_start_transfer(spi, tspi->cur);
>
> Not checking the returned error code. =A0If an error occurs, then the
> callback needs to be called to notify that the message did not
> complete. =A0However, this comment may be moot if the validation is
> moved out of spi_tegra_start_transfer().

moved


>> +static int spi_tegra_transfer(struct spi_device *spi, struct spi_messag=
e *m)
>> +{
>> + =A0 =A0 =A0 struct spi_tegra_data *tspi =3D spi_master_get_devdata(spi=
->master);
>> + =A0 =A0 =A0 unsigned long flags;
>> + =A0 =A0 =A0 int was_empty;
>> +
>> + =A0 =A0 =A0 if (list_empty(&m->transfers) || !m->complete)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
>
> It's a good idea to move most of the validation of the message from
> spi_tegra_start_message() and spi_tegra_start_transfer() to here so
> that the validation occurs outside of the spinlock. =A0It also means the
> driver doesn't discover badly formed messages part way through the
> transfer.

moved

>> + =A0 =A0 =A0 if (!request_mem_region(r->start, (r->end - r->start) + 1,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_name(&pdev->dev))) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -EBUSY;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err0;
>> + =A0 =A0 =A0 }
>
> I believe the platform bus does this for you already by calling
> insert_resource() on all the platform bus ranges. =A0See if /proc/iomem
> is any different with or without this call to verify.

You're right.  Didn't realize this


>> +static int __exit spi_tegra_remove(struct platform_device *pdev)
>
> __devexit

done

>> + =A0 =A0 =A0 r =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
>> + =A0 =A0 =A0 release_mem_region(r->start, (r->end - r->start) + 1);
>
> Ditto to comment earlier.

done


>> + =A0 =A0 =A0 .remove =3D =A0 =A0 =A0 __exit_p(spi_tegra_remove),
>
> __devexit_p

done


>> +subsys_initcall(spi_tegra_init);
>
> Is module_init() not sufficient?

All the other spi drivers use subsys_initcall

New patch coming soon.

Thanks,
    Erik

---------------------------------------------------------------------------=
---
This SF.net email is sponsored by =


Make an app they can't live without
Enter the BlackBerry Developer Challenge
http://p.sf.net/sfu/RIM-dev2dev =
