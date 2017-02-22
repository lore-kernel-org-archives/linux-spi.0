From: Cyrille Pitchen <cyrille.pitchen@wedev4u.fr>
Subject: Re: [PATCH v5 2/2] mtd: m25p80: Added pm ops support
Date: Wed, 22 Feb 2017 21:38:00 +0100
Message-ID: <a414f2cc-7e3d-f25d-cfc7-cab1d259a01e@wedev4u.fr>
References: <1487791173-22159-1-git-send-email-kdasu.kdev@gmail.com>
 <1487791173-22159-3-git-send-email-kdasu.kdev@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Cc: linux-mtd@lists.infradead.org, f.fainelli@gmail.com,
 bcm-kernel-feedback-list@broadcom.com
To: Kamal Dasu <kdasu.kdev@gmail.com>, linux-spi@vger.kernel.org,
 cyrille.pitchen@atmel.com, marex@denx.de, broonie@kernel.org
Return-path: <linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org>
In-Reply-To: <1487791173-22159-3-git-send-email-kdasu.kdev@gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mtd/>
List-Post: <mailto:linux-mtd@lists.infradead.org>
List-Help: <mailto:linux-mtd-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=subscribe>
Sender: "linux-mtd" <linux-mtd-bounces@lists.infradead.org>
Errors-To: linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org
List-Id: linux-spi.vger.kernel.org

Hi Kamal,

Le 22/02/2017 =E0 20:19, Kamal Dasu a =E9crit :
> Added power management ops for resume to be able to reinitialize
> spi-nor device and set it to right transfer mode in its pre-suspend
> state. Some SoC implementations might power down the spi-nor flash
> and loose its initial settings on suspend. A resume should restore
> part settings to its original pre-suspend state.
> =

> Signed-off-by: Kamal Dasu <kdasu.kdev@gmail.com>
> ---
>  drivers/mtd/devices/m25p80.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> =

> diff --git a/drivers/mtd/devices/m25p80.c b/drivers/mtd/devices/m25p80.c
> index c4df3b1..3ab30b2 100644
> --- a/drivers/mtd/devices/m25p80.c
> +++ b/drivers/mtd/devices/m25p80.c
> @@ -324,10 +324,21 @@ static int m25p_remove(struct spi_device *spi)
>  };
>  MODULE_DEVICE_TABLE(of, m25p_of_table);
>  =

> +#ifdef CONFIG_PM_SLEEP
> +static int m25p_resume(struct device *dev)
> +{
> +	struct m25p *flash =3D dev_get_drvdata(dev);
> +
> +	return spi_nor_init(&flash->spi_nor);
> +}
> +#endif
> +static SIMPLE_DEV_PM_OPS(m25p_pm_ops, NULL, m25p_resume);
> +
>  static struct spi_driver m25p80_driver =3D {
>  	.driver =3D {
>  		.name	=3D "m25p80",
>  		.of_match_table =3D m25p_of_table,
> +		.pm     =3D &m25p_pm_ops,
>  	},
>  	.id_table	=3D m25p_ids,
>  	.probe	=3D m25p_probe,
> =


I'm still studying the runtime_pm documentation and source code to
understand how the power management works in the Linux kernel.
I didn't finish but for what I have understood until now, I think there
is an issue.

Here you add suspend/resume handlers on the SPI device. So the SPI
sub-system is aware of the power state of the SPI flash memory, that
fine. However what about the MTD sub-system? I don't see any
synchronization between the SPI device and the MTD device. Hence I guess
the MTD sub-system is not aware of the actual power state of the
hardware memory. So I think that mtd->_read() or mtd->_write() handlers
could be called from some mtd driver when the SPI device has already
been suspended. For instance, let's image the root file-system is
mounted from a ubifs stored a SPI NOR flash: what if the kernel tries to
perform some file access when the SPI device has already been suspended?

The 'struct m25p' instance makes the link between the SPI device the the
spi_nor->mtd device. Sync could be done using this object.

That why I think this patch is currently incomplete as the
synchronization of the power states of both the SPI and MTD devices is
missing.

I think the feature you're trying to implement is interesting but some
rework seems to needed. I can't tell you more for now since, as I said,
I'm still lacking strong knowledge about the runtime_pm framework.

Best regards,

Cyrille

______________________________________________________
Linux MTD discussion mailing list
http://lists.infradead.org/mailman/listinfo/linux-mtd/
