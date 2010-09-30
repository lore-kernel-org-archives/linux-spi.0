From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH] spi/pl022: make sure the chip_info dev pointer is set
Date: Thu, 30 Sep 2010 23:33:43 +0900
Message-ID: <AANLkTimZXF-ntBSROV2pVN+Td1Bek7C5DtKZTQgXY=Wt@mail.gmail.com>
References: <1285839648-7368-1-git-send-email-linus.walleij@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Cc: spi-devel-general@lists.sourceforge.net,
	linux-arm-kernel@lists.infradead.org
To: Linus Walleij <linus.walleij@stericsson.com>
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1285839648-7368-1-git-send-email-linus.walleij@stericsson.com>
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

On Thu, Sep 30, 2010 at 6:40 PM, Linus Walleij
<linus.walleij@stericsson.com> wrote:
> We forgot to set the pointer back to the device if the user
> supplied all device settings, leading to crashing debug prints
> as controller data is verified.
>
> Signed-off-by: Linus Walleij <linus.walleij@stericsson.com>
> ---
> =A0drivers/spi/amba-pl022.c | =A0 =A02 ++
> =A01 files changed, 2 insertions(+), 0 deletions(-)
>
> diff --git a/drivers/spi/amba-pl022.c b/drivers/spi/amba-pl022.c
> index 4c37c4e..90a7e5d 100644
> --- a/drivers/spi/amba-pl022.c
> +++ b/drivers/spi/amba-pl022.c
> @@ -1574,6 +1574,8 @@ static int pl022_setup(struct spi_device *spi)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0chip_info->duplex =3D SSP_MICROWIRE_CHANNE=
L_FULL_DUPLEX;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0chip_info->cs_control =3D null_cs_control;
> =A0 =A0 =A0 =A0} else {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Users should not set this field */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 chip_info->dev =3D &spi->dev;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dev_dbg(&spi->dev,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"using user supplied contr=
oller_data settings\n");
> =A0 =A0 =A0 =A0}

Nack.  data passed to a driver via the controller_data must be
immutable as far as the device driver is concerned.  I realize that
this has been rather sloppy in the past; but I'm enforcing it now.
controller_data is static data passed to the driver, and the 'dev'
member of pl022_config_chip needs to be removed.

So, instead of setting the dev pointer here; this code should *remove*
the dev pointer from the structure and use spi->dev directly instead.
I've looked at the driver, and I don't see any significant locations
using chip_info that cannot get the chip_info directly from the struct
spi_device.

g.


> --
> 1.6.3.3
>
>



-- =

Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
