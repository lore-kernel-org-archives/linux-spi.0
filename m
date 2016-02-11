From: Martin Sperl <martin-d5rIkyn9cnPYtjvyW6yDsg@public.gmane.org>
Subject: Re: [PATCH 4/4] spi: bcm2835aux: fix CPOL/CPHA setting
Date: Thu, 11 Feb 2016 19:44:55 +0100
Message-ID: <26830EBF-A5F2-4BE3-88A2-C9E0A97A4881@sperl.org>
References: <1455041435-8015-1-git-send-email-stephanolbrich@gmx.de> <87a8n94e3x.fsf@eliezer.anholt.net> <16A848EA-6E08-48C4-B3DD-DF27333B7458@sperl.org> <10547867.CcbLVQlgyH@chaos-desktop> <50D0ECA7-8116-4248-AC85-6E1C8002A185@sperl.org>
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2104\))
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
	Eric Anholt <eric-WhKQ6XTQaPysTnJN9+BGXg@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Stephan Olbrich <stephanolbrich-Mmb7MZpHnFY@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <50D0ECA7-8116-4248-AC85-6E1C8002A185-d5rIkyn9cnPYtjvyW6yDsg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


> On 11.02.2016, at 17:19, Martin Sperl <martin-d5rIkyn9cnPYtjvyW6yDsg@public.gmane.org> wrote:

>> At the end with the last rising edge of SCLK MOSI goes to low and st=
ays there=20
>> while SCLK goes to low and then CS to inactive.
>>=20
>> So the slave has no chance to get the first bit but gets an addition=
al 0 at the=20
>> end.

Actually SPI says: sample AT the clock change - not shortly after.
So the behavior in principle is correct - even if it is not perfect...

>> It may not be easy visible with 0x00,0x82,0x00 as data, so could you=
 repeat=20
>> your test with 0xAA,0xFF if you see the same as I do or not?
>=20
> I did retest also with 0x81,0x00,0x81 and saw my expected behavior - =
but maybe
> me understanding of those modes is wrong.
>=20
> I will send you the images for the pattern I have generated with=20
> 0x81, 0x00, 0x81 as a personal email.


There is a means to add an additional HOLD time of 1, 4 or 7
system-clock cycles (undivided) that extend the period
while MOSI is still driven with the old bit value after the
clock change.

This can get fixed like this (copy paste, so tabs are spaces):

diff --git a/drivers/spi/spi-bcm2835aux.c b/drivers/spi/spi-bcm2835aux.=
c
index bd490c0..6052628 100644
--- a/drivers/spi/spi-bcm2835aux.c
+++ b/drivers/spi/spi-bcm2835aux.c
@@ -63,6 +63,10 @@
 #define BCM2835_AUX_SPI_CNTL0_VAR_CS   0x00008000
 #define BCM2835_AUX_SPI_CNTL0_VAR_WIDTH        0x00004000
 #define BCM2835_AUX_SPI_CNTL0_DOUTHOLD 0x00003000
+#define BCM2835_AUX_SPI_CNTL0_DOUTHOLD_0       0x00000000
+#define BCM2835_AUX_SPI_CNTL0_DOUTHOLD_1       0x00001000
+#define BCM2835_AUX_SPI_CNTL0_DOUTHOLD_4       0x00002000
+#define BCM2835_AUX_SPI_CNTL0_DOUTHOLD_7       0x00003000
 #define BCM2835_AUX_SPI_CNTL0_ENABLE   0x00000800
 #define BCM2835_AUX_SPI_CNTL0_CPHA_IN  0x00000400
 #define BCM2835_AUX_SPI_CNTL0_CLEARFIFO        0x00000200
@@ -341,10 +345,35 @@ static int bcm2835aux_spi_transfer_one(struct spi=
_master *
        } else { /* the slowest we can go */
                speed =3D BCM2835_AUX_SPI_CNTL0_SPEED_MAX;
        }
+       /* mask out old speed from previous spi_transfer */
+       bs->cntl[0] &=3D ~BCM2835_AUX_SPI_CNTL0_SPEED;
+       /* and set speed for this round */
        bs->cntl[0] |=3D speed << BCM2835_AUX_SPI_CNTL0_SPEED_SHIFT;

        spi_used_hz =3D clk_hz / (2 * (speed + 1));

+       /* and configure hold time - needs to take speed into account *=
/
+       /* first clear it */
+       bs->cntl[0] &=3D ~BCM2835_AUX_SPI_CNTL0_DOUTHOLD;
+       switch (speed) {
+       case 0: /* divider 2 */
+       case 1: /* divider 4 */
+               /* data hold time of 1 system clock cycle */
+               bs->cntl[0] |=3D BCM2835_AUX_SPI_CNTL0_DOUTHOLD_1;
+               break;
+       case 2: /* divider 6 */
+       case 3: /* divider 8 */
+       case 4: /* divider 10 */
+       case 5: /* divider 12 */
+               /* data hold time of 4 system clock cycle */
+               bs->cntl[0] |=3D BCM2835_AUX_SPI_CNTL0_DOUTHOLD_4;
+               break;
+       default: /* divider 14 and above */
+               /* data hold time of 7 system clock cycle */
+               bs->cntl[0] |=3D BCM2835_AUX_SPI_CNTL0_DOUTHOLD_7;
+               break;
+       }
+
        /* set transmit buffers and length */
        bs->tx_buf =3D tfr->tx_buf;
        bs->rx_buf =3D tfr->rx_buf;

It still means that CPHA=3D1 may fail to work with devices that
run a software based SPI implementation that has a delay between
clock change and sampling.
SPI slaves that latch the value on clock change should be fine.

Hopefully the policies for the delays were chosen wisely=E2=80=A6

But for all practical purposes the DOUTHOLD is 7 systen clock
cycles (undivided or .000000027s) for anything below=20
18.3MHz (=3D256MHz/(2*(1+6)).

If this is an unacceptable limitation, then we can disable CPHA
support by removing SPI_CPHA from BCM2835_AUX_SPI_MODE_BITS.

Maybe by making it a configuration option in the device-tree?

Martin--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
