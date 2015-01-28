From: BhuvanChandra.DV <bhuvanchandra.dv@toradex.com>
Subject: Re: [PATCH 3/7] spi: spi-fsl-dspi: Remove usage of devm_kzalloc
Date: Wed, 28 Jan 2015 07:05:55 +0000
Message-ID: <1422429099979.36592@toradex.com>
References: <1422356244-15629-1-git-send-email-bhuvanchandra.dv@toradex.com>
 <1422356244-15629-4-git-send-email-bhuvanchandra.dv@toradex.com>
 <20150127195234.GP21293@sirena.org.uk>
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
In-Reply-To: <20150127195234.GP21293@sirena.org.uk>
Content-Language: en-IN
Content-ID: <4DFFBB99900C8C4C913A540DE3462F9E@toradex.com>
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


On 01/28/2015 01:22 AM, Mark Brown wrote:
> On Tue, Jan 27, 2015 at 04:27:20PM +0530, Bhuvanchandra DV wrote:
>> devm_* API was supposed to be used only in probe function call.
>> Memory is allocated at 'probe' and free automatically at 'remove'.
> Applied, thanks.  Please don't dump entire backtraces into your commit
> logs - they're far too big and not very helpful, they can obscure real
> content in the message.  Explain in words what the problem is and if a
> backtrace helps illustrate that edit it down to only relevant portions
> rather than blindly including the entire thing.

OK
