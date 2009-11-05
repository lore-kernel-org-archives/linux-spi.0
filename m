From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 7/8] spi_mpc8xxx: Turn qe_mode into flags
Date: Thu, 5 Nov 2009 07:47:50 -0600
Message-ID: <3E303C4F-CE29-470F-B34A-3413F31BC23C@kernel.crashing.org>
References: <20091012164841.GA32214@oksana.dev.rtsoft.ru>
	<20091012164925.GG4578@oksana.dev.rtsoft.ru>
Mime-Version: 1.0 (Apple Message framework v1076)
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Cc: David Brownell <dbrownell@users.sourceforge.net>,
	Greg Kroah-Hartman <gregkh@suse.de>,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	spi-devel-general@lists.sourceforge.net,
	Andrew Morton <akpm@linux-foundation.org>
To: Anton Vorontsov <avorontsov@ru.mvista.com>
Return-path: <linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@lists.ozlabs.org>
In-Reply-To: <20091012164925.GG4578@oksana.dev.rtsoft.ru>
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

> Soon there will be more flags introduced in subsequent patches, so
> let's turn qe_mode into flags.
>
> Also introduce mpc8xxx_spi_strmode() and print current SPI mode.
>
> Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
> Acked-by: David Brownell <dbrownell@users.sourceforge.net>
> ---
> drivers/spi/spi_mpc8xxx.c   |   30 +++++++++++++++++++-----------
> include/linux/fsl_devices.h |    2 +-
> 2 files changed, 20 insertions(+), 12 deletions(-)

applied to next

- k
