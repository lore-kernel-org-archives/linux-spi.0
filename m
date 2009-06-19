From: Anton Vorontsov <avorontsov@ru.mvista.com>
Subject: Re: [PATCH -mm v3][POWERPC] mpc8xxx : allow SPI without cs.
Date: Fri, 19 Jun 2009 17:45:58 +0400
Message-ID: <20090619134558.GA18872@oksana.dev.rtsoft.ru>
References: <4A39DC80.7030906@arvoo.nl>
	<20090618130955.GA1369@oksana.dev.rtsoft.ru>
	<EEB9B7B7-5456-4AE9-8BB9-96DA04320697@kernel.crashing.org>
	<4A3B3D90.5030100@arvoo.nl>
Reply-To: avorontsov@ru.mvista.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general@lists.sourceforge.net,
	linuxppc-dev list <Linuxppc-dev@ozlabs.org>
To: Rini van Zetten <rini@arvoo.nl>
Return-path: <linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@lists.ozlabs.org>
Content-Disposition: inline
In-Reply-To: <4A3B3D90.5030100@arvoo.nl>
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

On Fri, Jun 19, 2009 at 09:26:08AM +0200, Rini van Zetten wrote:
> This patch adds the possibility to have a spi device without a cs.
>
> For example, the dts file should look something like this:
>
> spi-controller {
>        gpios = <&pio1 1 0      /* cs0 */
>                 0              /* cs1, no GPIO */
>                 &pio2 2 0>;    /* cs2 */
>
> Signed-off-by: Rini van Zetten <rini@arvoo.nl>
> ---
> Changes :
> 	patch against 2.6.30-rc8-mm1
> 	style updates
> 	compiler warning fix
> comment :
> 	This feature is needed on our home made board to program an onboard fpga.
> 	The fpga needs some special pin toggling to put it in programming mode.
> 	That's why we want to skip the usual gpio cs and do the pin toggling
> 	in our driver

Cool, thanks for the explanation. You may want to put it
into the commit message.

[...]
> +			ret = gpio_direction_output(pinfo->gpios[i],
> +					pinfo->alow_flags[i]);
> +			if (ret) {
> +				dev_err(dev, "can't set output direction for"
> +							"gpio #%d: %d\n",
> +							i, ret);

There is no space between 'for' and 'gpio' words.
(also the whole dev_err() may fit into two lines, no need to
split it into three lines).

Otherwise looks great. On the next resend feel free to add my
Acked-by: Anton Vorontsov <avorontsov@ru.mvista.com>

Thanks,

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
