From: Martin Sperl <kernel@martin.sperl.org>
Subject: Re: [PATCH v4 3/5] dt/bindings: bcm2835: add binding documentation for bcm2835-aux
Date: Fri, 4 Sep 2015 10:26:21 +0200
Message-ID: <9D45476C-88E2-4F76-AB55-9D0C7194E29C@martin.sperl.org>
References: <1440405608-3995-1-git-send-email-kernel@martin.sperl.org> <1440405608-3995-4-git-send-email-kernel@martin.sperl.org> <55DD1A13.7010705@wwwdotorg.org>
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2104\))
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: Lee Jones <lee@kernel.org>, Russell King <linux@arm.linux.org.uk>,
	Mark Brown <broonie@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	devicetree@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-spi@vger.kernel.org,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Rob Herring <robh+dt@kernel.org>,
	Pawel Moll <pawel.moll@arm.com>,
	Kumar Gala <galak@codeaurora.org>
To: Stephen Warren <swarren@wwwdotorg.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <55DD1A13.7010705@wwwdotorg.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


> On 26.08.2015, at 03:44, Stephen Warren <swarren@wwwdotorg.org> wrote:
> 
> On 08/24/2015 02:40 AM, kernel@martin.sperl.org wrote:
> 
>> +Example:
>> +
>> +aux_enable: aux_enable@0x7e215004 {
>> +	compatible = "bcrm,bcm2835-aux";
>> +	reg = <0x7e215004 0x04>;
> 
> I'd expect that to be <0x7e215000 0x8>;

The reason is that we just handle enable with this driver,
which just requires access to the 0x7e215004 register.

The 0x7e215000 register (interrupt mask) could be used by a
cascaded interrupt-controller, but as the spi and uart drivers
can run with shared interrupts this is not a necessity.

Martin
