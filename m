From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [spi-devel-general] [PATCH v4] powerpc/5200: Add mpc5200-spi
	(non-PSC) device driver
Date: Thu, 18 Jun 2009 07:35:28 -0600
Message-ID: <fa686aa40906180635g45724119x99cd4d1e4ede59f9@mail.gmail.com>
References: <20090618025030.12363.69402.stgit@localhost.localdomain>
	<20090618065814.GA12942@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Cc: linuxppc-dev@ozlabs.org, David Brownell <dbrownell@users.sourceforge.net>,
	linux-kernel@vger.kernel.org, spi-devel-general@lists.sourceforge.net
To: Wolfram Sang <w.sang@pengutronix.de>
Return-path: <linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@lists.ozlabs.org>
In-Reply-To: <20090618065814.GA12942@pengutronix.de>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Sender: linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@lists.ozlabs.org
List-Id: linux-spi.vger.kernel.org

On Thu, Jun 18, 2009 at 12:58 AM, Wolfram Sang<w.sang@pengutronix.de> wrote:
> Hi Grant,
>
> some comments below:

Hi Wolfram.  Thanks for the review.

> On Wed, Jun 17, 2009 at 08:55:01PM -0600, Grant Likely wrote:
>> +#include <linux/spi/mpc52xx_spi.h>
>
> Is this still needed? See last comment...

No, not needed at all.  Will remove.

>> +#include <linux/of_spi.h>
>> +#include <linux/io.h>
>> +#include <asm/time.h>
>
> Really asm?

Yes, really asm.  Needed for get_tlb()

>> +#include <asm/mpc52xx.h>
>> +
>> +MODULE_AUTHOR("Grant Likely <grant.likely@secretlab.ca>");
>> +MODULE_DESCRIPTION("MPC52xx SPI (non-PSC) Driver");
>> +MODULE_LICENSE("GPL");
>> +
>> +/* Register offsets */
>> +#define SPI_CTRL1 =A0 =A00x00
>> +#define SPI_CTRL1_SPIE =A0 =A0 =A0 =A0 =A0 =A0 =A0 (1 << 7)
>> +#define SPI_CTRL1_SPE =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(1 << 6)
>> +#define SPI_CTRL1_MSTR =A0 =A0 =A0 =A0 =A0 =A0 =A0 (1 << 4)
>> +#define SPI_CTRL1_CPOL =A0 =A0 =A0 =A0 =A0 =A0 =A0 (1 << 3)
>> +#define SPI_CTRL1_CPHA =A0 =A0 =A0 =A0 =A0 =A0 =A0 (1 << 2)
>> +#define SPI_CTRL1_SSOE =A0 =A0 =A0 =A0 =A0 =A0 =A0 (1 << 1)
>> +#define SPI_CTRL1_LSBFE =A0 =A0 =A0 =A0 =A0 =A0 =A0(1 << 0)
>> +
>> +#define SPI_CTRL2 =A0 =A00x01
>> +#define SPI_BRR =A0 =A0 =A0 =A0 =A0 =A0 =A00x04
>> +
>> +#define SPI_STATUS =A0 0x05
>> +#define SPI_STATUS_SPIF =A0 =A0 =A0 =A0 =A0 =A0 =A0(1 << 7)
>> +#define SPI_STATUS_WCOL =A0 =A0 =A0 =A0 =A0 =A0 =A0(1 << 6)
>> +#define SPI_STATUS_MODF =A0 =A0 =A0 =A0 =A0 =A0 =A0(1 << 4)
>> +
>> +#define SPI_DATA =A0 =A0 0x09
>> +#define SPI_PORTDATA 0x0d
>> +#define SPI_DATADIR =A00x10
>> +
>> +/* FSM state return values */
>> +#define FSM_STOP =A0 =A0 0 =A0 =A0 =A0 /* Nothing more for the state ma=
chine to */
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* do. =A0If s=
omething interesting happens */
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* then and IR=
Q will be received */
>
> s/and/an/? Throughout the comments, there is sometimes a double space.

The double spaces at the end of sentences are intentional.  It is
perhaps a bit quaint and old fashioned, but it is my writing style.

>
>> +#define FSM_POLL =A0 =A0 1 =A0 =A0 =A0 /* need to poll for completion, =
an IRQ is */
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* not expecte=
d */
>> +#define FSM_CONTINUE 2 =A0 =A0 =A0 /* Keep iterating the state machine =
*/
>> +
>> +/* Driver internal data */
>> +struct mpc52xx_spi {
>> + =A0 =A0 struct spi_master *master;
>> + =A0 =A0 u32 sysclk;
>
> unused?

yes, fixed.

>> + =A0 =A0 void __iomem *regs;
>> + =A0 =A0 int irq0; =A0 =A0 =A0 /* MODF irq */
>> + =A0 =A0 int irq1; =A0 =A0 =A0 /* SPIF irq */
>> + =A0 =A0 int ipb_freq;
>
> unsigned int will suit it better IMHO.

right.

>> +
>> + =A0 =A0 /* Statistics */
>> + =A0 =A0 int msg_count;
>> + =A0 =A0 int wcol_count;
>> + =A0 =A0 int wcol_ticks;
>> + =A0 =A0 u32 wcol_tx_timestamp;
>> + =A0 =A0 int modf_count;
>> + =A0 =A0 int byte_count;
>
> Hmm, there isn't even a debug-printout for those. Putting #ifdef DEBUG ar=
ound
> them will be ugly. Well, I can't make up if this is just overhead or usef=
ul
> debugging aid, so no real objection :)

There used to be a sysfs interface for dumping these, but it was an
ugly misuse.  I'd like to leave these in.  I still have the sysfs bits
in a private patch and I'm going to rework them for debugfs.

> But I wonder more about the usage of the SS pin and if this chipsel is ne=
eded
> at all (sadly I cannot test as I don't have any board with SPI connected =
to
> that device). You define the SS-pin as output, but do not set the SSOE-bi=
t.
> More, you use the MODF-feature, so the SS-pin should be defined as input?
> According to Table 17.3 in the PM, you have that pin defined as generic p=
urpose
> output.

That's right.  The SS handling by the SPI device is completely
useless, so this driver uses it as a GPIO and asserts it manually.
The MODF irq is probably irrelevant, but I'd like to leave it in for
completeness.

>> + =A0 =A0 /* initialize the device */
>> + =A0 =A0 out_8(regs+SPI_CTRL1, SPI_CTRL1_SPIE | SPI_CTRL1_SPE | SPI_CTR=
L1_MSTR);
>
> spaces around operator.

Intentional to keep from spilling past column 80; but I'll move the
missing spaces to around the | operators.  I think it is easier to
read that way.

>> diff --git a/include/linux/spi/mpc52xx_spi.h b/include/linux/spi/mpc52xx=
_spi.h
>> new file mode 100644
>> index 0000000..d1004cf
>> --- /dev/null
>> +++ b/include/linux/spi/mpc52xx_spi.h
>> @@ -0,0 +1,10 @@
>> +
>> +#ifndef INCLUDE_MPC5200_SPI_H
>> +#define INCLUDE_MPC5200_SPI_H
>> +
>> +extern void mpc52xx_spi_set_premessage_hook(struct spi_master *master,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 void (*hook)(struct spi_message *m,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0void *context),
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 void *hook_context);
>> +
>> +#endif
>
> This can be dropped for now and reintroduced when needed, I think.

Yeah, this is cruft.  Removed.

Thanks!
g.

-- =

Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
