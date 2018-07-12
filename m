From: Frieder Schrempf <frieder.schrempf@exceet.de>
Subject: Re: [PATCH v2 04/12] dt-bindings: spi: Move the bindings for the FSL
 QSPI driver
Date: Thu, 12 Jul 2018 10:11:20 +0200
Message-ID: <6ea89c5c-0a50-fade-7d72-ca5b804da418@exceet.de>
References: <1530789310-16254-1-git-send-email-frieder.schrempf@exceet.de>
 <1530789310-16254-5-git-send-email-frieder.schrempf@exceet.de>
 <20180711155404.GA15363@rob-hp-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
 yogeshnarayan.gaur@nxp.com, boris.brezillon@bootlin.com, richard@nod.at,
 prabhakar.kushwaha@nxp.com, linux-kernel@vger.kernel.org, shawnguo@kernel.org,
 linux-spi@vger.kernel.org, marek.vasut@gmail.com, han.xu@nxp.com,
 broonie@kernel.org, linux-mtd@lists.infradead.org, miquel.raynal@bootlin.com,
 fabio.estevam@nxp.com, david.wolfe@nxp.com, computersforpeace@gmail.com,
 dwmw2@infradead.org
To: Rob Herring <robh@kernel.org>
Return-path: <linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org>
In-Reply-To: <20180711155404.GA15363@rob-hp-laptop>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mtd/>
List-Post: <mailto:linux-mtd@lists.infradead.org>
List-Help: <mailto:linux-mtd-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=subscribe>
Sender: "linux-mtd" <linux-mtd-bounces@lists.infradead.org>
Errors-To: linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org
List-Id: linux-spi.vger.kernel.org

Hi Rob,

On 11.07.2018 17:54, Rob Herring wrote:
> On Thu, Jul 05, 2018 at 01:15:00PM +0200, Frieder Schrempf wrote:
>> Move the documentation of the old SPI NOR driver to the place of the new
>> SPI memory interface based driver.
>>
>> Signed-off-by: Frieder Schrempf <frieder.schrempf@exceet.de>
>> ---
>> Changes in v2:
>> ==============
>> * Split the moving and editing of the dt-bindings in two patches
>>
>>   .../devicetree/bindings/mtd/fsl-quadspi.txt     | 65 --------------------
>>   .../devicetree/bindings/spi/spi-fsl-qspi.txt    | 65 ++++++++++++++++++++
>>   2 files changed, 65 insertions(+), 65 deletions(-)
> 
> Next time, use the -M option so the move shows any real diffs.

Ok, I'll keep that in mind.

Thanks,
Frieder

> 
> Acked-by: Rob Herring <robh@kernel.org>
> 

______________________________________________________
Linux MTD discussion mailing list
http://lists.infradead.org/mailman/listinfo/linux-mtd/
