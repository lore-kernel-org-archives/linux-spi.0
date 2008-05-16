From: "Grant Likely" <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Subject: Re: [RFC PATCH 0/4] Describe SPI devices in the
	OF device tree and add mpc5200-spi driver
Date: Fri, 16 May 2008 15:32:20 -0600
Message-ID: <fa686aa40805161432w6b5243f9nb0d0c32a87d86d02@mail.gmail.com>
References: <20080516193054.28030.35126.stgit@trillian.secretlab.ca>
	<9e4733910805161327u4c42fd1dg5b09319d89db447c@mail.gmail.com>
	<fa686aa40805161348t52b94956w112ef6926ff30892@mail.gmail.com>
	<9e4733910805161425i2d6cc034y3377af053a4198b5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: fabrizio.garetto-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linuxppc-dev-mnsaURCQ41sdnm+yROfE0A@public.gmane.org,
	dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: "Jon Smirl" <jonsmirl-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <9e4733910805161425i2d6cc034y3377af053a4198b5-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Sender: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Fri, May 16, 2008 at 3:25 PM, Jon Smirl <jonsmirl-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> On 5/16/08, Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org> wrote:
>> On Fri, May 16, 2008 at 2:27 PM, Jon Smirl <jonsmirl-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
>>  > On 5/16/08, Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org> wrote:
>>  >> This series is a set of changes to allow the slaves on an SPI bus to be
>>  >>  described in the OF device tree (useful in arch/powerpc) and adds a driver
>>  >>  that uses it (the Freescale MPC5200 SoC's SPI device).
>>  >
>>  > Right now we have SPI hooked up to PSC3. Hardware engineer is gone but
>>  > I'll see if I can get him to alter things to use the SPI controller. I
>>  > have an old mail from him where he thinks the Phytec board is missing
>>  > a signal needed to use the SPI controller.
>>
>>
>> While I'd appreciate the testing, I suspect that you really don't want
>>  to do that.  The dedicated SPI controller isn't very good.  It only
>>  does a byte at a time and so is rather slow.  A PSC is SPI mode should
>>  be better (but I haven't tried it personally it yet).
>
> What is the device tree node for PSC3 supposed to look like when it
> has both serial and spi enabled?

The *PSC3 device* cannot support both serial and SPI at the same time.
 Only one mode works at a time...

However, *PSC3 pin group* has can be configured to route both the
*PSC3 device* and the *SPI device* signal out to the board at the same
time.

Pin routing is not something that is described by the device tree.
It's viewed as a board level initialization thing, similar to how DDR
RAM initialization is viewed.  Ideally, the bootloader will write the
correct value into port_config for pin routing and Linux will never
need to touch it.  If the bootloader cannot be changed, then
board-specific platform code can be added to fixup the port_config
setting.  However, the drivers should never touch or care about pin
routing.

Cheers,
g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft 
Defy all challenges. Microsoft(R) Visual Studio 2008. 
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
