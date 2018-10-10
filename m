From: Talel Shenhar <talel@amazon.com>
Subject: Re: [PATCH 1/2] dt-bindings: spi: dw: add cs-override property
Date: Wed, 10 Oct 2018 14:23:40 +0300
Message-ID: <dbac7f00-e9cc-ddac-5734-9763b5985ead@amazon.com>
References: <1539155293-21750-1-git-send-email-talel@amazon.com>
 <20181010101825.GA6294@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Cc: <linux-spi@vger.kernel.org>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <ronenk@amazon.com>,
        <barakw@amazon.com>, David Woodhouse <dwmw@amazon.co.uk>
To: Mark Brown <broonie@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181010101825.GA6294@sirena.org.uk>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org



On 10/10/2018 01:18 PM, Mark Brown wrote:
> On Wed, Oct 10, 2018 at 10:08:12AM +0300, Talel Shenhar wrote:
>
>> The dw spi controller has an auto-deselect of Chip-Select, in case there is
>> no data inside the Tx FIFO. While working on platforms with Alpine chips,
> Why would we ever want to use this behaviour?  It will be broken for any
> non-trivial SPI message such as those made with multiple transfers
> anyway.  Why not just unconditionally control it manually?

This behavior (auto-deselect of Chip-Select) is the default behavior of dw spi controller hw.
On Alpine chip there is additional behavior added to the dw spi controller hw that allows the sw to disable this behavior.
This patch allows the dw driver to enable this hw workaround and add the needed sw manual control for it.
