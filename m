From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 1/7] powerpc: Implement get_brgfreq() and get_baudrate()
	stubs
Date: Tue, 16 Dec 2008 12:24:04 -0600
Message-ID: <9226B1EC-0DEF-43BB-9051-AE356720A3F5@kernel.crashing.org>
References: <20081205200936.GA19137@oksana.dev.rtsoft.ru>
	<20081205201026.GA19758@oksana.dev.rtsoft.ru>
Mime-Version: 1.0 (Apple Message framework v929.2)
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Cc: linuxppc-dev@ozlabs.org, David Brownell <dbrownell@users.sourceforge.net>,
	spi-devel-general@lists.sourceforge.net
To: Anton Vorontsov <avorontsov@ru.mvista.com>
Return-path: <linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@ozlabs.org>
In-Reply-To: <20081205201026.GA19758@oksana.dev.rtsoft.ru>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>
Sender: linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@ozlabs.org
Errors-To: linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@ozlabs.org
List-Id: linux-spi.vger.kernel.org


On Dec 5, 2008, at 2:10 PM, Anton Vorontsov wrote:

> This is needed to not bother with ugly #ifdefs in the drivers.
>
> Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
> ---
> arch/powerpc/sysdev/fsl_soc.h |    5 +++++
> 1 files changed, 5 insertions(+), 0 deletions(-)

applied to next

- k
