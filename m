From: Michael Walle <michael@walle.cc>
Subject: Re: [PATCH v3 0/7] NXP DSPI bugfixes and support for LS1028A
Date: Tue, 10 Mar 2020 16:22:26 +0100
Message-ID: <59b07b7d70603c6b536a7354ed0ea8d8@walle.cc>
References: <20200310125542.5939-1-olteanv@gmail.com>
 <615284875b709f602d57e4a4621a83c1@walle.cc>
 <CA+h21hrYoHVDvsxT1EPWhYprL+zNHfE4MW7k4HxiK7ma4ZWn1g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Cc: Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        lkml <linux-kernel@vger.kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, Esben Haabendal <eha@deif.com>,
        angelo@sysam.it, andrew.smirnov@gmail.com,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Wei Chen <weic@nvidia.com>, Mohamed Hosny <mhosny@nvidia.com>,
        peng.ma@nxp.com
To: Vladimir Oltean <olteanv@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CA+h21hrYoHVDvsxT1EPWhYprL+zNHfE4MW7k4HxiK7ma4ZWn1g@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hi Vladimir,

Am 2020-03-10 15:56, schrieb Vladimir Oltean:
>> (2) Also, reading the flash, every second time there is (reproducibly)
>> an
>> IO error:
>> 
>> # hexdump -C /dev/mtd0
>> 00000000  68 75 68 75 0a ff ff ff  ff ff ff ff ff ff ff ff
>> |huhu............|
>> 00000010  ff ff ff ff ff ff ff ff  ff ff ff ff ff ff ff ff
>> |................|
>> *
>> 01000000
>> # hexdump -C /dev/mtd0
>> 00000000  68 75 68 75 0a ff ff ff  ff ff ff ff ff ff ff ff
>> |huhu............|
>> 00000010  ff ff ff ff ff ff ff ff  ff ff ff ff ff ff ff ff
>> |................|
>> *
>> hexdump: /dev/mtd0: Input/output error
>> 00dc0000
>> # hexdump -C /dev/mtd0
>> 00000000  68 75 68 75 0a ff ff ff  ff ff ff ff ff ff ff ff
>> |huhu............|
>> 00000010  ff ff ff ff ff ff ff ff  ff ff ff ff ff ff ff ff
>> |................|
>> *
>> 01000000
>> # hexdump -C /dev/mtd0
>> 00000000  68 75 68 75 0a ff ff ff  ff ff ff ff ff ff ff ff
>> |huhu............|
>> 00000010  ff ff ff ff ff ff ff ff  ff ff ff ff ff ff ff ff
>> |................|
>> *
>> hexdump: /dev/mtd0: Input/output error
>> 00e6a000
>> 
> 
> Just to be clear, issue 2 is seen only after you abort another
> transaction, right?

No, just normal uninterrupted reading. Just tried it right after
reboot. Doesn't seem to be every second time though, just random
which makes me wonder if that is another problem now. Also the
last successful reading is random.

buildroot login: root
# hexdump -C /dev/mtd0
00000000  31 32 33 34 35 ff ff ff  ff ff ff ff ff ff ff ff  
|12345...........|
00000010  ff ff ff ff ff ff ff ff  ff ff ff ff ff ff ff ff  
|................|
*
[   32.359156] random: crng init done
01000000
# hexdump -C /dev/mtd0
00000000  31 32 33 34 35 ff ff ff  ff ff ff ff ff ff ff ff  
|12345...........|
00000010  ff ff ff ff ff ff ff ff  ff ff ff ff ff ff ff ff  
|................|
*
01000000
# hexdump -C /dev/mtd0
00000000  31 32 33 34 35 ff ff ff  ff ff ff ff ff ff ff ff  
|12345...........|
00000010  ff ff ff ff ff ff ff ff  ff ff ff ff ff ff ff ff  
|................|
*
hexdump: /dev/mtd0: Input/output error
00166000
# hexdump -C /dev/mtd0
00000000  31 32 33 34 35 ff ff ff  ff ff ff ff ff ff ff ff  
|12345...........|
00000010  ff ff ff ff ff ff ff ff  ff ff ff ff ff ff ff ff  
|................|
*
hexdump: /dev/mtd0: Input/output error
00c68000
# hexdump -C /dev/mtd0
00000000  31 32 33 34 35 ff ff ff  ff ff ff ff ff ff ff ff  
|12345...........|
00000010  ff ff ff ff ff ff ff ff  ff ff ff ff ff ff ff ff  
|................|
*
hexdump: /dev/mtd0: Input/output error
00243000
#

-michael
