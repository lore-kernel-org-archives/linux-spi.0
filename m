From: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Subject: Re: [PATCH 2/2] spi/mmc_spi: mmc_spi
	adaptations for SPI bus locking API
Date: Wed, 17 Feb 2010 13:07:35 -0700
Message-ID: <fa686aa41002171207x237da42dsb513cf5c8e0478b0@mail.gmail.com>
References: <20100217191513.52392dd6.eschwab@online.de>
	<20100217191900.a57d0a60.eschwab@online.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Cc: David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, vapier-aBrp7R+bbdUdnm+yROfE0A@public.gmane.org,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, yi.li-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org
To: Ernst Schwab <eschwab-BGeptl67XyCzQB+pC5nmwQ@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20100217191900.a57d0a60.eschwab-BGeptl67XyCzQB+pC5nmwQ@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Wed, Feb 17, 2010 at 11:19 AM, Ernst Schwab <eschwab-BGeptl67XyCzQB+pC5nmwQ@public.gmane.org> wrote:
> From: Ernst Schwab <eschwab-BGeptl67XyCzQB+pC5nmwQ@public.gmane.org>
>
> Modification of the mmc_spi driver to use the SPI bus locking API.
> With this, the mmc_spi driver can be used together with other SPI
> devices on the same SPI bus. The exclusive access to the SPI bus is
> now managed in the SPI layer. The counting of chip selects in the probe
> function is no longer needed.
>
> Signed-off-by: Ernst Schwab <eschwab-BGeptl67XyCzQB+pC5nmwQ@public.gmane.org>

Looks good to me.

g.

> ---
> diff --git a/drivers/mmc/host/mmc_spi.c b/drivers/mmc/host/mmc_spi.c
> --- a/drivers/mmc/host/mmc_spi.c
> +++ b/drivers/mmc/host/mmc_spi.c
> @@ -181,7 +181,7 @@ mmc_spi_readbytes(struct mmc_spi_host *host, unsigned=
 len)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0host->data=
_dma, sizeof(*host->data),
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0DMA_FROM_D=
EVICE);
>
> - =A0 =A0 =A0 status =3D spi_sync(host->spi, &host->readback);
> + =A0 =A0 =A0 status =3D spi_sync_locked(host->spi, &host->readback);
>
> =A0 =A0 =A0 =A0if (host->dma_dev)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dma_sync_single_for_cpu(host->dma_dev,
> @@ -540,7 +540,7 @@ mmc_spi_command_send(struct mmc_spi_host *host,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0host->data=
_dma, sizeof(*host->data),
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0DMA_BIDIRE=
CTIONAL);
> =A0 =A0 =A0 =A0}
> - =A0 =A0 =A0 status =3D spi_sync(host->spi, &host->m);
> + =A0 =A0 =A0 status =3D spi_sync_locked(host->spi, &host->m);
>
> =A0 =A0 =A0 =A0if (host->dma_dev)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dma_sync_single_for_cpu(host->dma_dev,
> @@ -684,7 +684,7 @@ mmc_spi_writeblock(struct mmc_spi_host *host, struct =
spi_transfer *t,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0host->data=
_dma, sizeof(*scratch),
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0DMA_BIDIRE=
CTIONAL);
>
> - =A0 =A0 =A0 status =3D spi_sync(spi, &host->m);
> + =A0 =A0 =A0 status =3D spi_sync_locked(spi, &host->m);
>
> =A0 =A0 =A0 =A0if (status !=3D 0) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dev_dbg(&spi->dev, "write error (%d)\n", s=
tatus);
> @@ -821,7 +821,7 @@ mmc_spi_readblock(struct mmc_spi_host *host, struct s=
pi_transfer *t,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0DMA_FROM_D=
EVICE);
> =A0 =A0 =A0 =A0}
>
> - =A0 =A0 =A0 status =3D spi_sync(spi, &host->m);
> + =A0 =A0 =A0 status =3D spi_sync_locked(spi, &host->m);
>
> =A0 =A0 =A0 =A0if (host->dma_dev) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dma_sync_single_for_cpu(host->dma_dev,
> @@ -1017,7 +1017,7 @@ mmc_spi_data_do(struct mmc_spi_host *host, struct m=
mc_command *cmd,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0host->data_dma, sizeof(*scratch),
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0DMA_BIDIRECTIONAL);
>
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 tmp =3D spi_sync(spi, &host->m);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 tmp =3D spi_sync_locked(spi, &host->m);
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (host->dma_dev)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dma_sync_single_for_cpu(ho=
st->dma_dev,
> @@ -1083,6 +1083,9 @@ static void mmc_spi_request(struct mmc_host *mmc, s=
truct mmc_request *mrq)
> =A0 =A0 =A0 =A0}
> =A0#endif
>
> + =A0 =A0 =A0 /* request exclusive bus access */
> + =A0 =A0 =A0 spi_bus_lock(host->spi);
> +
> =A0 =A0 =A0 =A0/* issue command; then optionally data and stop */
> =A0 =A0 =A0 =A0status =3D mmc_spi_command_send(host, mrq, mrq->cmd, mrq->=
data !=3D NULL);
> =A0 =A0 =A0 =A0if (status =3D=3D 0 && mrq->data) {
> @@ -1093,6 +1096,9 @@ static void mmc_spi_request(struct mmc_host *mmc, s=
truct mmc_request *mrq)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mmc_cs_off(host);
> =A0 =A0 =A0 =A0}
>
> + =A0 =A0 =A0 /* release the bus */
> + =A0 =A0 =A0 spi_bus_unlock(host->spi);
> +
> =A0 =A0 =A0 =A0mmc_request_done(host->mmc, mrq);
> =A0}
>
> @@ -1289,23 +1295,6 @@ mmc_spi_detect_irq(int irq, void *mmc)
> =A0 =A0 =A0 =A0return IRQ_HANDLED;
> =A0}
>
> -struct count_children {
> - =A0 =A0 =A0 unsigned =A0 =A0 =A0 =A0n;
> - =A0 =A0 =A0 struct bus_type *bus;
> -};
> -
> -static int maybe_count_child(struct device *dev, void *c)
> -{
> - =A0 =A0 =A0 struct count_children *ccp =3D c;
> -
> - =A0 =A0 =A0 if (dev->bus =3D=3D ccp->bus) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (ccp->n)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EBUSY;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 ccp->n++;
> - =A0 =A0 =A0 }
> - =A0 =A0 =A0 return 0;
> -}
> -
> =A0static int mmc_spi_probe(struct spi_device *spi)
> =A0{
> =A0 =A0 =A0 =A0void =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*ones;
> @@ -1337,32 +1326,6 @@ static int mmc_spi_probe(struct spi_device *spi)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return status;
> =A0 =A0 =A0 =A0}
>
> - =A0 =A0 =A0 /* We can use the bus safely iff nobody else will interfere=
 with us.
> - =A0 =A0 =A0 =A0* Most commands consist of one SPI message to issue a co=
mmand, then
> - =A0 =A0 =A0 =A0* several more to collect its response, then possibly mo=
re for data
> - =A0 =A0 =A0 =A0* transfer. =A0Clocking access to other devices during t=
hat period will
> - =A0 =A0 =A0 =A0* corrupt the command execution.
> - =A0 =A0 =A0 =A0*
> - =A0 =A0 =A0 =A0* Until we have software primitives which guarantee non-=
interference,
> - =A0 =A0 =A0 =A0* we'll aim for a hardware-level guarantee.
> - =A0 =A0 =A0 =A0*
> - =A0 =A0 =A0 =A0* REVISIT we can't guarantee another device won't be add=
ed later...
> - =A0 =A0 =A0 =A0*/
> - =A0 =A0 =A0 if (spi->master->num_chipselect > 1) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct count_children cc;
> -
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 cc.n =3D 0;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 cc.bus =3D spi->dev.bus;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 status =3D device_for_each_child(spi->dev.p=
arent, &cc,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 maybe_count=
_child);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (status < 0) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&spi->dev, "can't s=
hare SPI bus\n");
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return status;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> -
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_warn(&spi->dev, "ASSUMING SPI bus stays=
 unshared!\n");
> - =A0 =A0 =A0 }
> -
> =A0 =A0 =A0 =A0/* We need a supply of ones to transmit. =A0This is the on=
ly time
> =A0 =A0 =A0 =A0 * the CPU touches these, so cache coherency isn't a conce=
rn.
> =A0 =A0 =A0 =A0 *
>
>
>



-- =

Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.

---------------------------------------------------------------------------=
---
SOLARIS 10 is the OS for Data Centers - provides features such as DTrace,
Predictive Self Healing and Award Winning ZFS. Get Solaris 10 NOW
http://p.sf.net/sfu/solaris-dev2dev
