From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH -mm][POWERPC] mpc8xxx : allow SPI without cs.
Date: Thu, 18 Jun 2009 09:04:46 -0500
Message-ID: <EEB9B7B7-5456-4AE9-8BB9-96DA04320697@kernel.crashing.org>
References: <4A39DC80.7030906@arvoo.nl>
	<20090618130955.GA1369@oksana.dev.rtsoft.ru>
Mime-Version: 1.0 (Apple Message framework v935.3)
Content-Type: text/plain; charset="us-ascii"; Format="flowed"; DelSp="yes"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general@lists.sourceforge.net, Rini van Zetten <rini@arvoo.nl>,
	linuxppc-dev list <Linuxppc-dev@ozlabs.org>
To: avorontsov@ru.mvista.com
Return-path: <linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@lists.ozlabs.org>
In-Reply-To: <20090618130955.GA1369@oksana.dev.rtsoft.ru>
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


On Jun 18, 2009, at 8:09 AM, Anton Vorontsov wrote:

> On Thu, Jun 18, 2009 at 08:19:44AM +0200, Rini van Zetten wrote:
>> This patch adds the possibility to have a spi device without a cs.
>>
>> For example, the dts file should look something like this:
>>
>> spi-controller {
>>       gpios = <&pio1 1 0      /* cs0 */
>>                0              /* cs1, no GPIO */
>>                &pio2 2 0>;    /* cs2 */
>>
>
> Interesting scheme. I guess this is for eSPI controllers that can
> do their own chip-selects, but we want GPIO chip selects in addition
> (or in place of built-in ones), correct?

That is a good question.  What HW is this for (I don't think its for  
eSPI but I could be wrong).

- k
