From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 0/9] Some work for spi_mpc83xx driver, spi-mmc support
	for MPC8610HPCD
Date: Mon, 4 May 2009 13:55:04 -0700
Message-ID: <20090504135504.a6a6afcf.akpm@linux-foundation.org>
References: <20090430234739.GA27709@oksana.dev.rtsoft.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: linuxppc-dev@ozlabs.org, dbrownell@users.sourceforge.net,
	linux-kernel@vger.kernel.org, spi-devel-general@lists.sourceforge.net
To: avorontsov@ru.mvista.com
Return-path: <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@ozlabs.org>
In-Reply-To: <20090430234739.GA27709@oksana.dev.rtsoft.ru>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>
Sender: linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@ozlabs.org
Errors-To: linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@ozlabs.org
List-Id: linux-spi.vger.kernel.org

On Fri, 1 May 2009 03:47:39 +0400
Anton Vorontsov <avorontsov@ru.mvista.com> wrote:

> Here are few patches that are needed to support spi-mmc slot on
> MPC8610HPCD PowerPC boards:
> 
> [1/9] spi_mpc83xx: Handles other Freescale processors
> [2/9] spi_mpc83xx: Quieten down the "Requested speed is too low" message
> [3/9] spi_mpc83xx: Add small delay after asserting chip-select line
> [4/9] powerpc/86xx: Add MMC SPI support for MPC8610HPCD boards
> 

Some or all of these seem appropriate to 2.6.30 and perhaps even -stable?
