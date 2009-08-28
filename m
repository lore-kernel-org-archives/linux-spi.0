From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 1/8] powerpc/cpm: Remove SPI defines and spi structs
Date: Fri, 28 Aug 2009 00:45:34 -0500
Message-ID: <C37BD1BB-7F53-4CC7-ABB0-BBBDDAC5C052@kernel.crashing.org>
References: <20090818220304.GA23640@oksana.dev.rtsoft.ru>
	<20090818220410.GA25090@oksana.dev.rtsoft.ru>
Mime-Version: 1.0 (Apple Message framework v936)
Content-Type: text/plain; charset="us-ascii"; Format="flowed"; DelSp="yes"
Content-Transfer-Encoding: 7bit
Cc: David Brownell <dbrownell@users.sourceforge.net>,
	Greg Kroah-Hartman <gregkh@suse.de>,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	spi-devel-general@lists.sourceforge.net,
	Andrew Morton <akpm@linux-foundation.org>
To: Anton Vorontsov <avorontsov@ru.mvista.com>
Return-path: <linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@lists.ozlabs.org>
In-Reply-To: <20090818220410.GA25090@oksana.dev.rtsoft.ru>
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


On Aug 18, 2009, at 5:04 PM, Anton Vorontsov wrote:

> When cpm2.h included into spi_mpc8xxx driver, the SPI defines
> in the header conflict with defines in the driver.
>
> We don't need them in the header file, so remove them. Plus
> remove "struct spi", we'll use a better version in the driver.
>
> Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
> ---
> arch/powerpc/include/asm/cpm1.h |   45  
> ---------------------------------------
> arch/powerpc/include/asm/cpm2.h |   39  
> ---------------------------------
> 2 files changed, 0 insertions(+), 84 deletions(-)

applied to next

- k
