From: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Subject: Re: [spi-devel-general] [PATCH 0/3] davinci: spi: replace existing
	SPI driver
Date: Sun, 27 Jun 2010 00:03:13 -0600
Message-ID: <AANLkTilTTgTchq_w0CktXokOxGX32lmRyPqrTyFI9LCF@mail.gmail.com>
References: <1276530901-4413-1-git-send-email-bniebuhr@efjohnson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Cc: Tejun Heo <tj-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
        davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
To: Brian Niebuhr <bniebuhr3-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
In-Reply-To: <1276530901-4413-1-git-send-email-bniebuhr-JaPwekKOx1yaMJb+Lgu22Q@public.gmane.org>
List-Unsubscribe: <http://linux.davincidsp.com/mailman/options/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=unsubscribe>
List-Archive: <http://linux.davincidsp.com/pipermail/davinci-linux-open-source>
List-Post: <mailto:davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
List-Help: <mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=help>
List-Subscribe: <http://linux.davincidsp.com/mailman/listinfo/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=subscribe>
Sender: davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
Errors-To: davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Any users of the current davinci_spi driver care to comment on this
series?  I'm hesitant to apply a complete replacement to a driver that
was only added in December without having a lot more information.

Tejun or Sandeep, any comments?

Thanks,
g.

On Mon, Jun 14, 2010 at 9:54 AM, Brian Niebuhr <bniebuhr3-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> NOTE
>
> This patch requires the EDMA patch at:
>
> http://linux.davincidsp.com/pipermail/davinci-linux-open-source/2010-Marc=
h/018022.html
>
> which has since been reverted out of the davinci kernel.
>
>
> INTRODUCTION
>
> I have been working on a custom OMAP-L138 board that has multiple spi
> devices (seven) on one controller. =A0These devices have a wide range of
> transfer parameters (speed, phase, polarity, internal and gpio chip
> selects). =A0During my testing I found multiple errors in the davinci spi
> driver as a result of this complex setup. =A0The primary issues were:
>
> 1. There is a race condition due to the SPIBUF read busy-waits for slow
> =A0 =A0 =A0 =A0devices
> 2. I found some DMA transfer length errors under some conditions
> 3. The chip select code caused extra byte transfers (with no chip
> =A0 =A0 =A0 =A0select active) due to writes to SPIDAT1
> 4. Several issues prevented using multiple SPI devices, especially
> =A0 =A0 =A0 =A0the DMA code, as disucussed previously on the davinci list.
>
> The fixes to these problems were not simple. =A0I ended up making fairly
> large changes to the driver, and those changes are contained in these
> patches. =A0The full list of changes follows.
>
> CHANGE LIST
>
> 1. davinci_spi_chipelect() now performs both activation and deactivation
> =A0 =A0 =A0 =A0of chip selects. =A0This lets spi_bitbang fully control ch=
ip
> =A0 =A0 =A0 =A0select activation, as intended by the SPI API.
> 2. Chip select activation does not cause extra writes to the SPI bus
> 3. Chip select activation does not use SPIDEF for control. =A0This change
> =A0 =A0 =A0 =A0will also allow for implementation of inverted (active hig=
h)
> =A0 =A0 =A0 =A0chip selects in the future.
> 4. Added back gpio chip select capability from the old driver
> 5. Fixed prescale calculation for non-integer fractions of spi clock
> 6. Allow specification of SPI transfer parameters on a per-device
> =A0 =A0 =A0 =A0(instead of per-controller) basis
> 7. Allow specification of polled, interrupt-based, or DMA operation on
> =A0 =A0 =A0 =A0a per-device basis
> 8. Allow DMA with when more than one device is connected
> 9. Combined pio and dma txrx_bufs functions into one since they share
> =A0 =A0 =A0 =A0large parts of their functionality, and to simplify item (=
8).
> 10. Use only SPIFMT0 to allow more than 4 devices
>
> TESTING
>
> I have tested the driver using a custom SPI stress test on my
> OMAP-L138-based board with three devices connected. =A0I have tested
> configurations with all three devices polled, all three interrupt-based,
> all three DMA, and a mixture.
>
> I have compiled with the davinci_all_defconfig, but I don't have EVMs
> for the other davinci platforms to test with.
>
> SUMMARY
>
> This patch solves a lot of issues that should save a lot of people time
> down the road. =A0Since I posted the original patch I have had at least 5
> people contact me personally to get help applying the patch because SPI
> was broken on their boards. =A0I have heard back from at least 2 that the
> original patch worked for them.
>
> I appreciate any testing and feedback that others can provide.
>
> Brian Niebuhr (3):
> =A0davinci: spi: remove old Davinci SPI driver
> =A0davinci: spi: add replacement SPI driver
> =A0davinci: spi: modify platform data for updated SPI driver
>
> =A0arch/arm/mach-davinci/board-dm355-evm.c =A0 =A0 | =A0 10 +
> =A0arch/arm/mach-davinci/board-dm355-leopard.c | =A0 10 +
> =A0arch/arm/mach-davinci/board-dm365-evm.c =A0 =A0 | =A0 10 +
> =A0arch/arm/mach-davinci/dm355.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0 =A06 -
> =A0arch/arm/mach-davinci/dm365.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0 =A06 -
> =A0arch/arm/mach-davinci/include/mach/spi.h =A0 =A0| =A0 41 +-
> =A0drivers/spi/davinci_spi.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | 1196 +=
+++++++++-----------------
> =A0drivers/spi/davinci_spi.h =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0186=
 +++++
> =A08 files changed, 681 insertions(+), 784 deletions(-)
> =A0create mode 100644 drivers/spi/davinci_spi.h
>
>
> -------------------------------------------------------------------------=
-----
> ThinkGeek and WIRED's GeekDad team up for the Ultimate
> GeekDad Father's Day Giveaway. ONE MASSIVE PRIZE to the
> lucky parental unit. =A0See the prize list and enter to win:
> http://p.sf.net/sfu/thinkgeek-promo
> _______________________________________________
> spi-devel-general mailing list
> spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> https://lists.sourceforge.net/lists/listinfo/spi-devel-general
>



-- =

Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
