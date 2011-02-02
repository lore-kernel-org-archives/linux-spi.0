From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH] spi: spidev: Add 32 bit compat ioctl()
Date: Wed, 2 Feb 2011 07:15:12 -0700
Message-ID: <AANLkTikbXYxyUmBsPNO6mxB2x_4Qr49BQZTKrqvsiK8a@mail.gmail.com>
References: <1296646296-31843-1-git-send-email-walle@corscience.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: dbrownell@users.sourceforge.net,
	spi-devel-general@lists.sourceforge.net,
	linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
	arnd@arndb.de
To: Bernhard Walle <walle@corscience.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1296646296-31843-1-git-send-email-walle@corscience.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Wed, Feb 2, 2011 at 4:31 AM, Bernhard Walle <walle@corscience.de> wr=
ote:
> Add the compat_ioctl for operations on /dev/spi* so that 32 bit
> userspace applications can access SPI. As far as I can see all data
> structure are already prepared for that, so no additional conversion =
has
> to be done.
>
> My use case is MIPS with N32 userspace ABI and toolchain, and that wa=
s
> also the platform where I tested it successfully (Cavium Octeon).
>
> Signed-off-by: Bernhard Walle <walle@corscience.de>
> ---
> =A0drivers/spi/spidev.c | =A0 12 ++++++++++++
> =A01 files changed, 12 insertions(+), 0 deletions(-)
>
> diff --git a/drivers/spi/spidev.c b/drivers/spi/spidev.c
> index 4e6245e..f80503b 100644
> --- a/drivers/spi/spidev.c
> +++ b/drivers/spi/spidev.c
> @@ -30,6 +30,7 @@
> =A0#include <linux/errno.h>
> =A0#include <linux/mutex.h>
> =A0#include <linux/slab.h>
> +#include <linux/compat.h>
>
> =A0#include <linux/spi/spi.h>
> =A0#include <linux/spi/spidev.h>
> @@ -471,6 +472,14 @@ spidev_ioctl(struct file *filp, unsigned int cmd=
, unsigned long arg)
> =A0 =A0 =A0 =A0return retval;
> =A0}
>
> +#ifdef CONFIG_COMPAT
> +static long
> +spidev_compat_ioctl(struct file *filp, unsigned int cmd, unsigned lo=
ng arg)
> +{
> + =A0 =A0 =A0 return spidev_ioctl(filp, cmd, (unsigned long)compat_pt=
r(arg));
> +}
> +#endif /* CONFIG_COMPAT */

If you do the following...
+#else /* CONFIG_COMPAT */
+#define spidev_compat_ioctl NULL
+#endif /* CONFIG_COMPAT */

> +
> =A0static int spidev_open(struct inode *inode, struct file *filp)
> =A0{
> =A0 =A0 =A0 =A0struct spidev_data =A0 =A0 =A0*spidev;
> @@ -543,6 +552,9 @@ static const struct file_operations spidev_fops =3D=
 {
> =A0 =A0 =A0 =A0.write =3D =A0 =A0 =A0 =A0spidev_write,
> =A0 =A0 =A0 =A0.read =3D =A0 =A0 =A0 =A0 spidev_read,
> =A0 =A0 =A0 =A0.unlocked_ioctl =3D spidev_ioctl,
> +#ifdef CONFIG_COMPAT
> + =A0 =A0 =A0 .compat_ioctl =3D spidev_compat_ioctl,
> +#endif

Then the #ifdef/#endif can be dropped here which is tidier.

g.

> =A0 =A0 =A0 =A0.open =3D =A0 =A0 =A0 =A0 spidev_open,
> =A0 =A0 =A0 =A0.release =3D =A0 =A0 =A0spidev_release,
> =A0 =A0 =A0 =A0.llseek =3D =A0 =A0 =A0 no_llseek,
> --
> 1.7.1
>
>



--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
