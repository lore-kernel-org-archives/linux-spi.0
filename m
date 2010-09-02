From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH v4] spi: add spi_tegra driver
Date: Thu, 2 Sep 2010 08:22:49 -0600
Message-ID: <AANLkTimonLa1mUVSHR=QnR48HPtAZ5BW3BsVsg7MWALy@mail.gmail.com>
References: <1282771395-21684-1-git-send-email-konkers@android.com>
	<1283379393-14831-1-git-send-email-konkers@android.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Cc: linux-tegra@vger.kernel.org, spi-devel-general@lists.sourceforge.net,
	Thierry Reding <thierry.reding@avionic-design.de>,
	Russell King <linux@arm.linux.org.uk>, linux-arm-kernel@lists.infradead.org
To: Erik Gilling <konkers@android.com>
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1283379393-14831-1-git-send-email-konkers@android.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
List-Id: linux-spi.vger.kernel.org

On Wed, Sep 1, 2010 at 4:16 PM, Erik Gilling <konkers@android.com> wrote:
> v2 changes:
> =A0from Thierry Reding:
> =A0 =A0* add "select TEGRA_SYSTEM_DMA" to Kconfig
> =A0from Grant Likely:
> =A0 =A0* add oneline description to header
> =A0 =A0* inline references to DRIVER_NAME
> =A0 =A0* inline references to BUSY_TIMEOUT
> =A0 =A0* open coded bytes_per_word()
> =A0 =A0* spi_readl/writel -> spi_tegra_readl/writel
> =A0 =A0* move transfer validation to spi_tegra_transfer
> =A0 =A0* don't request_mem_region iomem as platform bus does that for us
> =A0 =A0* __exit -> __devexit
>
> v3 changes:
> =A0from Russell King:
> =A0 =A0* put request_mem_region back int
> =A0from Grant Likely:
> =A0 =A0* remove #undef DEBUG
> =A0 =A0* add SLINK_ to register bit defines
> =A0 =A0* remove unused bytes_per_word
> =A0 =A0* make spi_tegra_readl/writel static linine
> =A0 =A0* various refactoring for clarity
> =A0 =A0* mark err if BSY bit is not cleared after 1000 retries
> =A0 =A0* move spinlock to protect setting of RDY bit
> =A0 =A0* subsys_initcall -> module_init
>
> v3 changes:
> =A0from Grant Likely:
> =A0 =A0* update spi_tegra to use PTR_ERRless dma API
>
> Signed-off-by: Erik Gilling <konkers@android.com>
> Cc: Thierry Reding <thierry.reding@avionic-design.de>
> Cc: Grant Likely <grant.likely@secretlab.ca>
> Cc: Russell King <linux@arm.linux.org.uk>

Hi Erik,

Go ahead and add my Acked-by line and merge this via the tegra tree to
avoid ordering issues.  I also have a few more minor comments below.

g.

> + =A0 =A0 =A0 /* FIXME: should probably control CS manually so that we ca=
n be sure
> + =A0 =A0 =A0 =A0* it does not go low between transfer and to support del=
ay_usecs
> + =A0 =A0 =A0 =A0* correctly.
> + =A0 =A0 =A0 =A0*/

Yes, you'll probably want to revisit this.  A lot of SPI hardware
doesn't understand that the actual transfer may be longer that the
data it immediately knows about.  Also, it is common to use GPIOs as
chip selects.

> +static void spi_tegra_cleanup(struct spi_device *spi)
> +{
> + =A0 =A0 =A0 dev_dbg(&spi->dev, "cleanup\n");
> +}

Remove the empty hook

> +static int __init spi_tegra_probe(struct platform_device *pdev)
> +{
> + =A0 =A0 =A0 struct spi_master =A0 =A0 =A0 *master;
> + =A0 =A0 =A0 struct spi_tegra_data =A0 *tspi;
> + =A0 =A0 =A0 struct resource =A0 =A0 =A0 =A0 *r;
> + =A0 =A0 =A0 int ret;
> +
> + =A0 =A0 =A0 master =3D spi_alloc_master(&pdev->dev, sizeof *tspi);
> + =A0 =A0 =A0 if (master =3D=3D NULL) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&pdev->dev, "master allocation fail=
ed\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENOMEM;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 /* the spi->mode bits understood by this driver: */
> + =A0 =A0 =A0 master->mode_bits =3D SPI_CPOL | SPI_CPHA | SPI_CS_HIGH;
> +
> + =A0 =A0 =A0 if (pdev->id !=3D -1)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 master->bus_num =3D pdev->id;

even if pdev->id is -1, you probably want to set master->bus_num to is
so that a spi bus number can be dynamically assigned.
