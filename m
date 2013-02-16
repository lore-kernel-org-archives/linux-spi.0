From: Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>
Subject: Re: [PATCH v2 1/4] arm: mvebu: Add support for SPI controller in
	Armada 370/XP
Date: Sat, 16 Feb 2013 10:12:00 -0500
Message-ID: <20130216151200.GS14746@titan.lakedaemon.net>
References: <1360155984-15397-1-git-send-email-ezequiel.garcia@free-electrons.com>
	<1360155984-15397-2-git-send-email-ezequiel.garcia@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Thomas Petazzoni <thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>,
	Lior Amsalem <alior-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>,
	devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org,
	Gregory Clement <gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	Florian Fainelli <florian-p3rKhJxN3npAfugRpC6u6w@public.gmane.org>,
	linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Ezequiel Garcia <ezequiel.garcia-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1360155984-15397-2-git-send-email-ezequiel.garcia-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Wed, Feb 06, 2013 at 10:06:21AM -0300, Ezequiel Garcia wrote:
> The Armada 370 and Armada XP SoC has an SPI controller.
> This patch adds support for this controller in Armada 370
> and Armada XP SoC common device tree files.
> 
> Note that the Armada XP SPI register length is 0x50 bytes,
> while Armada 370 SPI register length is 0x28 bytes,
> so we choose the smaller of the two.
> 
> Cc: Thomas Petazzoni <thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
> Cc: Lior Amsalem <alior-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>
> Acked-by: Gregory Clement <gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
> Signed-off-by: Ezequiel Garcia <ezequiel.garcia-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
> ---
> Changes from v1:
>  * Register offset must be 0x28 instead of 0x50,
>    as pointed out by Gregory
> 
>  arch/arm/boot/dts/armada-370-xp.dtsi |   22 ++++++++++++++++++++++
>  1 files changed, 22 insertions(+), 0 deletions(-)

Applied to mvebu/dt, resolved an add/add (i2c, mvsdio, usb) conflict.

thx,

Jason.

------------------------------------------------------------------------------
The Go Parallel Website, sponsored by Intel - in partnership with Geeknet, 
is your hub for all things parallel software development, from weekly thought 
leadership blogs to news, videos, case studies, tutorials, tech docs, 
whitepapers, evaluation guides, and opinion stories. Check out the most 
recent posts - join the conversation now. http://goparallel.sourceforge.net/
