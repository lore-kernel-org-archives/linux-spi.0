From: Gregory CLEMENT <gregory.clement@free-electrons.com>
Subject: Re: [PATCH 2/3] spi: orion: Fix extended baud rates for each Armada
 SoCs
Date: Tue, 26 May 2015 14:20:08 +0200
Message-ID: <556464F8.1020707@free-electrons.com>
References: <1432633484-18758-1-git-send-email-gregory.clement@free-electrons.com>
 <1432633484-18758-3-git-send-email-gregory.clement@free-electrons.com>
 <20150526120853.GB28523@lunn.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
 Boris BREZILLON <boris.brezillon@free-electrons.com>,
 Jason Cooper <jason@lakedaemon.net>, Tawfik Bayouk <tawfik@marvell.com>,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-spi@vger.kernel.org, Nadav Haklai <nadavh@marvell.com>,
 Lior Amsalem <alior@marvell.com>,
 Ezequiel Garcia <ezequiel.garcia@free-electrons.com>,
 Maxime Ripard <maxime.ripard@free-electrons.com>,
 linux-arm-kernel@lists.infradead.org,
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>, Mark Brown <broonie@kernel.org>
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20150526120853.GB28523@lunn.ch>
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

Hi Andrew, Mark,

On 26/05/2015 14:08, Andrew Lunn wrote:
>> --- a/Documentation/devicetree/bindings/spi/spi-orion.txt
>> +++ b/Documentation/devicetree/bindings/spi/spi-orion.txt
>> @@ -1,7 +1,13 @@
>>  Marvell Orion SPI device
>>  
>>  Required properties:
>> -- compatible : should be "marvell,orion-spi" or "marvell,armada-370-spi".
>> +- compatible : should be on of the following:
>> +    - "marvell,orion-spi" for the Orion, mv78x00, Kirkwood and Dove SoCs
>> +    - "marvell,armada-370-spi", for the Armada 370 SoCs
>> +    - "marvell,armada-375-spi", for the Armada 375 SoCs
>> +    - "marvell,armada-380-spi", for the Armada 38x SoCs
>> +    - "marvell,armada-390-spi", for the Armada 38x SoCs
> 
> Hi Gregory
> 
> Is that a typ0?

yes it is! :/

Mark do you want a new patch or do you prefer fixing the typo
yourself ? it should be
    - "marvell,armada-390-spi", for the Armada 39x SoCs
instead of
    - "marvell,armada-390-spi", for the Armada 38x SoCs

s/38x/39x/ on this line.


Thanks,

Gregory


> 
>    Andrew
> 


-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
