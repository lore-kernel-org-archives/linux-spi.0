From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: Re: [PATCH] powerpc/devicetrees: Change 'gpios' to 'cs-gpios' on
 fsl,spi nodes
Date: Sat, 14 Dec 2019 08:30:11 +0100
Message-ID: <678cdcce-9bad-519a-68a5-a43414c15f94@c-s.fr>
References: <7556683b57d8ce100855857f03d1cd3d2903d045.1574943062.git.christophe.leroy@c-s.fr>
 <20191213213418.GA17361@bogus>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Mark Rutland <mark.rutland@arm.com>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, devicetree@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-spi@vger.kernel.org
To: Rob Herring <robh@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191213213418.GA17361@bogus>
Content-Language: fr
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org



Le 13/12/2019 à 22:34, Rob Herring a écrit :
> On Thu, Nov 28, 2019 at 12:16:35PM +0000, Christophe Leroy wrote:
>> Since commit 0f0581b24bd0 ("spi: fsl: Convert to use CS GPIO
>> descriptors"), the prefered way to define chipselect GPIOs is using
>> 'cs-gpios' property instead of the legacy 'gpios' property.
> 
> This will break using a new dtb on a kernel without the above commit. Or
> with any OS that never made the change.

Why would anybody use a new dtb on an old kernel ? I have not tagged 
this change for stable, it will only apply to DTBs in new kernels, won't 
it ?

That's not the first time DTS have to change for new kernels. For 
instance, some time ago I had to replace all 'gpios' property by a set 
of 'rdy-gpio', 'nce-gpio', 'ale-gpio' and 'cle-gpio' properties to 
continue using 'gpio-control-nand' driver.

> 
> I'm fine with the doc change, but you should keep 'gpios' as deprecated.

Ok

Christophe
