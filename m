From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 5/8] spi_mpc8xxx: Fix uninitialized variable
Date: Fri, 28 Aug 2009 00:48:50 -0500
Message-ID: <0A998CA2-4E4E-4104-A5F4-235B4B746EAA@kernel.crashing.org>
References: <20090818220304.GA23640@oksana.dev.rtsoft.ru>
	<20090818220419.GE25090@oksana.dev.rtsoft.ru>
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
In-Reply-To: <20090818220419.GE25090@oksana.dev.rtsoft.ru>
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

> This patch fixes the following warning:
>
> CC      drivers/spi/spi_mpc8xxx.o
>  spi_mpc8xxx.c: In function 'of_mpc8xxx_spi_probe':
>  spi_mpc8xxx.c:681: warning: 'ret' may be used uninitialized in this  
> function
>
> Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
> ---
> drivers/spi/spi_mpc8xxx.c |    1 +
> 1 files changed, 1 insertions(+), 0 deletions(-)

Acked-by: Kumar Gala <galak@kernel.crashing.org>

- k
