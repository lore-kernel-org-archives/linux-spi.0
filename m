From: Talel Shenhar <talel@amazon.com>
Subject: Re: [PATCH 2/2] dw: spi: add support for Alpine spi controller
Date: Thu, 11 Oct 2018 14:22:28 +0300
Message-ID: <a319e310-1296-3b9e-abfe-bd33c3d8bb9d@amazon.com>
References: <1539155293-21750-1-git-send-email-talel@amazon.com>
 <1539184516-8200-1-git-send-email-talel@amazon.com>
 <1539184516-8200-2-git-send-email-talel@amazon.com>
 <1539209339.1944.23.camel@impinj.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: "dwmw@amazon.co.uk" <dwmw@amazon.co.uk>,
        "jonnyc@amazon.com" <jonnyc@amazon.com>,
        "ronenk@amazon.com" <ronenk@amazon.com>,
        "barakw@amazon.com" <barakw@amazon.com>
To: Trent Piepho <tpiepho@impinj.com>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1539209339.1944.23.camel@impinj.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


On 10/11/2018 01:08 AM, Trent Piepho wrote:
> On Wed, 2018-10-10 at 18:15 +0300, Talel Shenhar wrote:
>> Add support for a new devicetree compatible string called
>> 'al,alpine-apb-ssi', which is necessary for the Amazon Alpine spi
>> controller. 'al,alpine-dw-apb-ssi' is used in the dw spi driver if
>> specified in the devicetree.  Otherwise, fall back to driver default
>> behavior, i.e. original dw IP hw driver behavior.
>>
>> Signed-off-by: Talel Shenhar <talel@amazon.com>
>> Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
> Shouldn't this be "amzn,alpine-apb-ssi"?  The convention, and this IS
> documented, is to the use company's stock ticker symbol as the prefix,
> so as to have something grounded in the real world.  I don't know of
> anyone else using a product line name as the company name in their dt
> bindings.  Example, "snps,dw-apb-ssi", is named for Synopsis, not the
> Designware line.
>
updated the vendor prefix to "amazon" as described in bindings/vendor-prefixes.txt.
