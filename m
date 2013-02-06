From: Gregory CLEMENT <gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH v2 0/4] ARM: mvebu: Add support for SPI flash devices
	in Armada 370/XP
Date: Wed, 06 Feb 2013 14:16:54 +0100
Message-ID: <511257C6.2070604@free-electrons.com>
References: <1360155984-15397-1-git-send-email-ezequiel.garcia@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Thomas Petazzoni <thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>,
	Lior Amsalem <alior-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>,
	Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	Florian Fainelli <florian-p3rKhJxN3npAfugRpC6u6w@public.gmane.org>,
	linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Ezequiel Garcia <ezequiel.garcia-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1360155984-15397-1-git-send-email-ezequiel.garcia-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On 02/06/2013 02:06 PM, Ezequiel Garcia wrote:
> This is second version of the SPI patchset for Armada 370/XP.
> 
> This series first adds support for the SPI controller
> and then adds the SPI flash for the Armada XP GP board.
> 
> This series is based on 3.8-rc5 plus:
>  * "arm: mvebu: support for the new Armada XP development board(DB-MV784MP-GP)"
>  * "arm: mvebu: i2c come back in defconfig"
> 
> Feel free to test or provide any feedback!
> 
Ezequiel,

I reviewed the patches, I have nothing more to say, I can add my:

Acked-by: Gregory Clement <gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>

on the patch that didn't have yet.

Jason,
could you add this series in your incoming pull request?

Thanks,

> Ezequiel Garcia (4):
>   arm: mvebu: Add support for SPI controller in Armada 370/XP
>   ARM: mvebu: Update defconfig to select SPI support
>   arm: mvebu: Add SPI flash on Armada XP-GP board
>   ARM: mvebu: Update defconfig to select SPI flash and MTD support
> 
>  arch/arm/boot/dts/armada-370-xp.dtsi |   22 ++++++++++++++++++++++
>  arch/arm/boot/dts/armada-xp-gp.dts   |   12 ++++++++++++
>  arch/arm/configs/mvebu_defconfig     |    5 +++++
>  3 files changed, 39 insertions(+), 0 deletions(-)
> 
> Thanks,
> 
>     Ezequiel
> 


-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com

------------------------------------------------------------------------------
Free Next-Gen Firewall Hardware Offer
Buy your Sophos next-gen firewall before the end March 2013 
and get the hardware for free! Learn more.
http://p.sf.net/sfu/sophos-d2d-feb
