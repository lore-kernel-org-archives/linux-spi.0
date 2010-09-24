From: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH] spi_mpc8xxx: issue with using definition of pram in
	Device Tree
Date: Fri, 24 Sep 2010 10:12:08 -0500
Message-ID: <20100924101208.7916cfa9@udp111988uds.am.freescale.net>
References: <20100916070503.10046C7391@messagerie.si.c-s.fr>
	<20100924071006.GA21318@angua.secretlab.ca> <4C9C513B.40501@c-s.fr>
	<20100924075740.GA20599@oksana.dev.rtsoft.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: LEROY Christophe <christophe.leroy@c-s.fr>,
	spi-devel-general@lists.sourceforge.net,
	David Brownell <dbrownell@users.sourceforge.net>,
	linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
To: Anton Vorontsov <cbouatmailru@gmail.com>
Return-path: <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
In-Reply-To: <20100924075740.GA20599@oksana.dev.rtsoft.ru>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Sender: linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org
List-Id: linux-spi.vger.kernel.org

On Fri, 24 Sep 2010 11:57:40 +0400
Anton Vorontsov <cbouatmailru@gmail.com> wrote:

> Doesn't explain why that worked on MPC8272 (CPM2) and MPC8560
> (also CPM2) machines though. But here's my guess (I no longer
> have these boards to test it):
> 
> On 8272 I used this node:
> 
> +                       spi@4c0 {
> +                               #address-cells = <1>;
> +                               #size-cells = <0>;
> +                               compatible = "fsl,cpm2-spi", "fsl,spi";
> +                               reg = <0x11a80 0x40 0x89fc 0x2>;
> 
> On that SOC there are two muram data regions 0x0..0x2000 and
> 0x9000..0x9100. Note that we actually don't want "data" regions,
> and the only reason why that worked is that sysdev/cpm_common.c
> maps muram(0)..muram(max).

Wouldn't it still fail the rh_alloc_fixed call?

-Scott
