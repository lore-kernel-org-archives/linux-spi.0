From: BhuvanChandra.DV <bhuvanchandra.dv@toradex.com>
Subject: Re: [PATCH 7/7] spi: spi-fsl-dspi: Add support for TCFQ transfer mode
Date: Thu, 29 Jan 2015 12:53:57 +0000
Message-ID: <1422536382672.21760@toradex.com>
References: <1422356608-15961-1-git-send-email-bhuvanchandra.dv@toradex.com>
 <1422356608-15961-2-git-send-email-bhuvanchandra.dv@toradex.com>
 <20150128190342.GE21293@sirena.org.uk> <1422533049999.91114@toradex.com>
 <20150129121320.GI21293@sirena.org.uk>
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
In-Reply-To: <20150129121320.GI21293@sirena.org.uk>
Content-Language: en-IN
Content-ID: <2EB79AB5DBC01549B4F66E2879FBDED3@toradex.com>
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


On 01/29/2015 05:43 PM, Mark Brown wrote:
> On Thu, Jan 29, 2015 at 11:58:25AM +0000, BhuvanChandra.DV wrote:
>
>> As far as i understood the major difference between the two modes are when
>> the interrupt to trigger, as EOQ mode will trigger the interrupt at end of
>> queue and TCF will trigger the interrupt at every frame transfer. Probably
>> mode selection shouldn't be a device tree property, but i don't see any
>> automatic way to choose between the modes.
>> Maybe a config would be more appropriate?
> Or if there's either no particular reason to choose one over the other
> or one is always better then just pick one in the driver and don't worry
> about implementing both.

Among the two, EOQ would be better since with TCF, interrupts are generated at
every frame transfer, which could be a problem at higher frequencies.
I think we can omit this patch then.
