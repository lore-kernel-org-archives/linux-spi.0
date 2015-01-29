From: BhuvanChandra.DV <bhuvanchandra.dv@toradex.com>
Subject: Re: [PATCH 7/7] spi: spi-fsl-dspi: Add support for TCFQ transfer mode
Date: Thu, 29 Jan 2015 11:58:25 +0000
Message-ID: <1422533049999.91114@toradex.com>
References: <1422356608-15961-1-git-send-email-bhuvanchandra.dv@toradex.com>
 <1422356608-15961-2-git-send-email-bhuvanchandra.dv@toradex.com>
 <20150128190342.GE21293@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: "mark.rutland@arm.com" <mark.rutland@arm.com>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux@arm.linux.org.uk" <linux@arm.linux.org.uk>,
 "B44548@freescale.com" <B44548@freescale.com>,
 "pawel.moll@arm.com" <pawel.moll@arm.com>,
 "ijc+devicetree@hellion.org.uk" <ijc+devicetree@hellion.org.uk>,
 "Li.Xiubo@freescale.com" <Li.Xiubo@freescale.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "stefan@agner.ch" <stefan@agner.ch>,
 "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
 "robh+dt@kernel.org" <robh+dt@kernel.org>,
 "galak@codeaurora.org" <galak@codeaurora.org>,
 "shawn.guo@linaro.org" <shawn.guo@linaro.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
To: Mark Brown <broonie@kernel.org>
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20150128190342.GE21293@sirena.org.uk>
Content-Language: en-IN
Content-ID: <A6F915F439DC7C4E816B817C61BC688E@toradex.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
List-Id: linux-spi.vger.kernel.org


On 01/29/2015 12:33 AM, Mark Brown wrote:
> On Tue, Jan 27, 2015 at 04:33:28PM +0530, Bhuvanchandra DV wrote:
>
>> TCFQ is interrupt of Transfer Complete Flag in DSPI module.
>> EOQ is interrupt of End of Queue Flag in DSPI module.
>> For adopting of different platform, either of them is a way of DSPI
>> transfer data. This patch add TCF support for DSPI module  in other platform.
> I can't really understand what the purpose of this is, sorry.  What are
> these modes and why would one choose one over the other?  Your changelog
> suggests this is being done per board which implies that it's tuning for
> performance but that's usually something that should be done in device
> drivers, not the device tree - perhaps the tuning will change over time
> as the driver is optimized or perhaps it varies depending on the
> transfer.
>
> The code mentions a DMA option as well, generally where it's available
> DMA is something that's chosen at runtime based on the length of the
> transfer.

As far as i understood the major difference between the two modes are when
the interrupt to trigger, as EOQ mode will trigger the interrupt at end of
queue and TCF will trigger the interrupt at every frame transfer. Probably
mode selection shouldn't be a device tree property, but i don't see any
automatic way to choose between the modes.
Maybe a config would be more appropriate?

@Chao, is there any specific reason to implement this mode?
