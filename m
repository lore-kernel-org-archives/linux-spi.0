From: <Tudor.Ambarus@microchip.com>
Subject: Re: [PATCH v2 1/3] mtd: spi-nor: hisi-sfc: Try to provide some
 clarity on which SFC we are
Date: Thu, 16 Jan 2020 11:03:40 +0000
Message-ID: <38021504.DDLjaa3fGf@localhost.localdomain>
References: <1575900490-74467-1-git-send-email-john.garry@huawei.com>
 <1575900490-74467-2-git-send-email-john.garry@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Cc: <broonie@kernel.org>, <marek.vasut@gmail.com>,
        <linuxarm@huawei.com>, <linux-kernel@vger.kernel.org>,
        <linux-mtd@lists.infradead.org>, <linux-spi@vger.kernel.org>,
        <xuejiancheng@hisilicon.com>, <fengsheng5@huawei.com>,
        <chenxiang66@hisilicon.com>
To: <john.garry@huawei.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1575900490-74467-2-git-send-email-john.garry@huawei.com>
Content-Language: en-US
Content-ID: <62518802EC87D140AEBB9D9B17F20A25@namprd11.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Monday, December 9, 2019 4:08:08 PM EET John Garry wrote:
> The driver is for the HiSilicon FMC (Flash Memory Controller), which
> supports SPI NOR in addition other memory technologies, like SPI NAND.
>=20
> Indeed, the naming in the driver is a little inappropriate, especially
> considering that there is already another HiSilicon SPI NOR flash
> controller (which I believe the FMC is derived from).
>=20
> Since we now want to provide software support for this other HiSilicon
> controller, update code comments to at least try to make it clear that
> this driver is for the FMC.
>=20
> Signed-off-by: John Garry <john.garry@huawei.com>
> ---
>  drivers/mtd/spi-nor/Kconfig    | 4 ++--
>  drivers/mtd/spi-nor/hisi-sfc.c | 2 +-
>  2 files changed, 3 insertions(+), 3 deletions(-)
>=20

Applied to spi-nor/next.

Thanks,
ta
