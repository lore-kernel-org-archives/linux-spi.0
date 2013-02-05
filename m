From: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Subject: Re: [PATCH V2 0/2] spi/bcm63xx: fix multi transfer messages
Date: Tue, 05 Feb 2013 14:30:40 +0000
Message-ID: <20130205143040.208603E1265@localhost>
References: <1359900913-4472-1-git-send-email-jogo@openwrt.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Maxime Bizon <mbizon-MmRyKUhfbQ9GWvitb5QawA@public.gmane.org>,
	Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>,
	Florian Fainelli <florian-p3rKhJxN3npAfugRpC6u6w@public.gmane.org>, Kevin Cernekee <cernekee-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
To: Jonas Gorski <jogo-p3rKhJxN3npAfugRpC6u6w@public.gmane.org>, spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1359900913-4472-1-git-send-email-jogo-p3rKhJxN3npAfugRpC6u6w@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Sun,  3 Feb 2013 15:15:11 +0100, Jonas Gorski <jogo-p3rKhJxN3npAfugRpC6u6w@public.gmane.org> wrote:
> The bcm63xx SPI controller does not support keeping CS up after doing a
> transfer. Since this is problematic for most typical use cases, this
> patchset introduces a workaround by combining small enough messages
> to one transfer, rejecting anything that can't be fulfilled with the
> hardware.
> 
> Patch one properly rejects anything impossible to transfer with these
> limitations.
> Patch two introduces logic for combining transfers to one to be able to
> use it for typical use cases (register accesses and flash access).
> 
> Build and run tested on a BCM6368 with a SPI controlled switch attached
> requiring write-then-read with CS asserted.
> 
> Changes V1 -> V2:
>  * split into two patches
>  * fixed return type of bcm63xx_txrx_bufs()
>  * slightly reworked bcm63xx_txrx_bufs, obsoleting one local variable
>  * added a bit more comments in the code
>  * added error messages indicated why transfers were rejected

Another option is to allow longer transfers if a GPIO is used for the CS
line. A lot of SPI controllers need to do that.

That isn't a critique of this patch because it is essentially a bug fix,
but rather a way you can work around the limitation.

g.

> 
> Jonas Gorski (2):
>   spi/bcm63xx: reject transfers unable to transfer
>   spi/bcm63xx: work around inability to keep CS up
> 
>  drivers/spi/spi-bcm63xx.c |  179 +++++++++++++++++++++++++++++++--------------
>  1 file changed, 125 insertions(+), 54 deletions(-)
> 
> -- 
> 1.7.10.4
> 

-- 
Grant Likely, B.Sc, P.Eng.
Secret Lab Technologies, Ltd.

------------------------------------------------------------------------------
Free Next-Gen Firewall Hardware Offer
Buy your Sophos next-gen firewall before the end March 2013 
and get the hardware for free! Learn more.
http://p.sf.net/sfu/sophos-d2d-feb
