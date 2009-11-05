From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 8/8] spi_mpc8xxx: Add support for QE DMA mode and
	CPM1/CPM2 chips
Date: Thu, 5 Nov 2009 07:47:56 -0600
Message-ID: <D0B2174D-6EED-4D57-A011-FAFEF64AB794@kernel.crashing.org>
References: <20091012164841.GA32214@oksana.dev.rtsoft.ru>
	<20091012164927.GH4578@oksana.dev.rtsoft.ru>
Mime-Version: 1.0 (Apple Message framework v1076)
Content-Type: text/plain; charset="us-ascii"; Format="flowed"; DelSp="yes"
Content-Transfer-Encoding: 7bit
Cc: David Brownell <dbrownell@users.sourceforge.net>,
	Greg Kroah-Hartman <gregkh@suse.de>,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	spi-devel-general@lists.sourceforge.net,
	Andrew Morton <akpm@linux-foundation.org>
To: Anton Vorontsov <avorontsov@ru.mvista.com>
Return-path: <linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@lists.ozlabs.org>
In-Reply-To: <20091012164927.GH4578@oksana.dev.rtsoft.ru>
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


On Oct 12, 2009, at 11:49 AM, Anton Vorontsov wrote:

> This patch adds QE buffer descriptors mode support for the
> spi_mpc8xxx driver, and as a side effect we now support CPM1
> and CPM2 SPI controllers.
>
> That means that today we support almost all MPC SPI controllers:
>
> - MPC834x-style controllers (support PIO mode only);
> - CPM1 and CPM2 controllers (support DMA mode only);
> - QE SPI controllers in CPU mode (PIO mode with shift quirks);
> - QE SPI controllers in buffer descriptors (DMA) mode;
>
> The only controller we don't currently support is a newer eSPI
> (with a dedicated chip selects and a bit different registers map).
>
> Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
> Acked-by: David Brownell <dbrownell@users.sourceforge.net>
> ---
> drivers/spi/Kconfig       |    3 -
> drivers/spi/spi_mpc8xxx.c |  540 ++++++++++++++++++++++++++++++++++++ 
> +++++----
> 2 files changed, 500 insertions(+), 43 deletions(-)

applied to next

- k
