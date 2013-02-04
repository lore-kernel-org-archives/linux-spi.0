From: Florian Fainelli <florian-p3rKhJxN3npAfugRpC6u6w@public.gmane.org>
Subject: Re: [PATCH V2 0/2] spi/bcm63xx: fix multi transfer messages
Date: Mon, 04 Feb 2013 14:29:00 +0100
Message-ID: <510FB79C.8040801@openwrt.org>
References: <1359900913-4472-1-git-send-email-jogo@openwrt.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	Kevin Cernekee <cernekee-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>,
	Maxime Bizon <mbizon-MmRyKUhfbQ9GWvitb5QawA@public.gmane.org>
To: Jonas Gorski <jogo-p3rKhJxN3npAfugRpC6u6w@public.gmane.org>
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

On 02/03/2013 03:15 PM, Jonas Gorski wrote:
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
>   * split into two patches
>   * fixed return type of bcm63xx_txrx_bufs()
>   * slightly reworked bcm63xx_txrx_bufs, obsoleting one local variable
>   * added a bit more comments in the code
>   * added error messages indicated why transfers were rejected

Looks good, thanks!

Acked-by: Florian Fainelli <florian-p3rKhJxN3npAfugRpC6u6w@public.gmane.org>
--
Florian

------------------------------------------------------------------------------
Everyone hates slow websites. So do we.
Make your web apps faster with AppDynamics
Download AppDynamics Lite for free today:
http://p.sf.net/sfu/appdyn_d2d_jan
