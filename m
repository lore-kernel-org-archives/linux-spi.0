From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [PATCH v9 2/3] spi: Add Renesas R-Car Gen3 RPC-IF SPI controller
 driver
Date: Tue, 14 May 2019 22:13:10 +0300
Message-ID: <e0720e41-23da-2aa5-636b-777568974b17@cogentembedded.com>
References: <1553847606-18122-1-git-send-email-masonccyang@mxic.com.tw>
 <1553847606-18122-3-git-send-email-masonccyang@mxic.com.tw>
 <1e2bf23d-db39-0d1d-0bcc-6d9cd2935a82@cogentembedded.com>
 <cdee3d53-6ee3-4435-117e-8ba4a58ca72b@cogentembedded.com>
 <OF82CE76E9.E6395EF7-ON482583DD.000E37D7-482583DD.000E5077@mxic.com.tw>
 <3d334751-8fd4-7db1-9deb-e6c94936df13@cogentembedded.com>
 <OF4ABCC306.B053BA23-ON482583E0.000F480C-482583E0.000FAD4A@mxic.com.tw>
 <3971c669-9095-9d18-d029-37f9663a54b2@cogentembedded.com>
 <OF58AAFF49.C4593DEB-ON482583E1.001D551E-482583E1.001F089D@mxic.com.tw>
 <9014077e-2648-adad-72c1-baf834f5a511@cogentembedded.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: bbrezillon@kernel.org, broonie@kernel.org,
        devicetree@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Simon Horman <horms@verge.net.au>, juliensu@mxic.com.tw,
        lee.jones@linaro.org, linux-kernel@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, linux-spi@vger.kernel.org,
        marek.vasut@gmail.com, mark.rutland@arm.com, robh+dt@kernel.org,
        zhengxunli@mxic.com.tw
To: masonccyang@mxic.com.tw
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <9014077e-2648-adad-72c1-baf834f5a511@cogentembedded.com>
Content-Language: en-MW
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On 05/14/2019 10:06 PM, Sergei Shtylyov wrote:

[...]
>>>>>>>> Have you tested reading? v8 patch still works while v9 patches
>>>>>>>> hang on doing:
>>>>>>>>
>>>>>>>> $ cat /dev/mtd<n>...
>>>>>>>
>>>>>>>    Sorry, 'od -x', not 'cat'.
>>>>>>
>>>>>> root@draak:/# cat /proc/mtd
>>>>>> dev:    size   erasesize  name
>>>>>> mtd0: 00040000 00001000 "Bank 1 - Boot parameter"
>>>>>> mtd1: 00140000 00001000 "Bank 1 - Loader-BL2"
>>>>>> mtd2: 00040000 00001000 "Bank 1 - Certification"
>>>>>> mtd3: 00080000 00001000 "Bank 1 - ARM Trusted FW"
>>>>>> mtd4: 00400000 00001000 "Bank 1 - Reserved-1"
>>>>>> mtd5: 00300000 00001000 "Bank 1 - U-Boot"
>>>>>> mtd6: 00200000 00001000 "Bank 1 - Reserved-2"
>>>>>> mtd7: 00480000 00001000 "Bank 1 - Splash"
>>>>>> mtd8: 00040000 00001000 "Bank 1 - Device Tree"
>>>>>> root@draak:/# od -x /dev/mtd1
>>>>>> 0000000 0000 d280 0001 d280 0002 d280 0003 d280
>>>>>> 0000020 0004 d280 0005 d280 0006 d280 0007 d280
>>>>>> 0000040 0008 d280 0009 d280 000a d280 000b d280
>>>>>> 0000060 000c d280 000d d280 000e d280 000f d280
>>>>>> 0000100 0010 d280 0011 d280 0012 d280 0013 d280
>>>>>> 0000120 0014 d280 0015 d280 0016 d280 0017 d280
>>>>>> 0000140 0018 d280 0019 d280 001a d280 001b d280
>>>>>> 0000160 001c d280 001d d280 001e d280 1000 d53e
>>>>>> 0000200 f800 9266 1000 d51e 3fdf d503 3ba0 1005
>>>>>
>>>>>    Still hangs for me. After I patches spi-mem.c and the driver to
>>>>> call RPM for the MFD, it started working again. Perhaps, that clock>> >> is still enabled on your target. What does the following print (for
> 
>    Even with these issues worked around, I still see strange behavior on
> writes, e.g. after I mount JFFS2 partition, remove 1 file, unmount, re-mount,
> and mount again, the removed file is back! :-/

   Too many re-mounts, one was enough. :-)

> [...]
> 
>> thanks & best regards,
>> Mason

MBR, Sergei
