From: Kamal Dasu <kdasu.kdev@gmail.com>
Subject: Re: [PATCH v2,
 1/1] mtd: devices: m25p80: Add PM suspend resume support
Date: Fri, 20 Jan 2017 13:50:47 -0500
Message-ID: <CAC=U0a3Q_dBefFayi4G2TueZNXYAhdakduSwYdKPxDDL5Uoi_A@mail.gmail.com>
References: <1473710494-4084-1-git-send-email-kdasu.kdev@gmail.com>
 <4fe502a4-ee01-3fb8-6697-161de814596e@atmel.com>
 <CAKekbeubczM5NpQy-Umqx-SmDM+deMcgYciyST2Sgrh2_dOsAw@mail.gmail.com>
 <c9198202-29d1-5e67-f675-5a53d926ede9@atmel.com>
 <fa44881d-701b-195a-9617-239454645183@gmail.com>
 <CAC=U0a3HRrx+0Y8YGSiDdfEigkQGa-QxHJ53tK1-Yo-iTj=yXA@mail.gmail.com>
 <af540565-2347-4f51-a5a7-e65f3d26c258@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Florian Fainelli <f.fainelli@gmail.com>,
 Jayachandran C <jchandra@broadcom.com>, linux-spi <linux-spi@vger.kernel.org>,
 Marek Vasut <marek.vasut@gmail.com>,
 bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>,
 MTD Maling List <linux-mtd@lists.infradead.org>,
 Cyrille Pitchen <cyrille.pitchen@atmel.com>,
 Brian Norris <computersforpeace@gmail.com>,
 Kamal Dasu <kamal.dasu@broadcom.com>
To: Marek Vasut <marex@denx.de>
Return-path: <linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org>
In-Reply-To: <af540565-2347-4f51-a5a7-e65f3d26c258@denx.de>
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

On Fri, Jan 20, 2017 at 12:22 PM, Marek Vasut <marex@denx.de> wrote:
> On 01/20/2017 05:33 PM, Kamal Dasu wrote:
>> Marek,
>>
>>>>
>>>> OK, so I'm fine with leaving the patch as is for now but I would like Marek
>>>> review just to be sure we didn't miss something: Marek, any comments?
>>>>
>>>> I just have one more comment below but it's only a detail.
>>>
>>> What would happen if you have a FS attached on this SPI NOR (like UBIFS)
>>> and you suspend with this patch ? Will it survive ?
>>>
>>>
>>
>> I have tried with both jffs2 rw and ubifs rw rootfs on spi-nor
>> booting from spi-nor partitions while  active filesystem operations
>> were going on over suspend/resume cycles. And it survives.
>
> Can you elaborate on your test a bit ?
>

The power management test  puts  board in standby mode,  during
standby the DRAM is in refresh and power to the spi-nor is removed.
After a set timeout the board wakes up again and resumes from where it
left off. This pm test is run while a cp command is invoked where a
file is transferred to the rw rootfs. The test loops through said
number of iterations of suspend and resumes cycles. The copy
operations is eventually done over a few cycles. Once the test is
completed  filesystem should have no corruptions, the copied files
should compare and rootfs should be intact.  This test was repeated
with jffs2 as well as ubifs rootfs flashed on spi-nor device.

> --
> Best regards,
> Marek Vasut

Thanks
Kamal

______________________________________________________
Linux MTD discussion mailing list
http://lists.infradead.org/mailman/listinfo/linux-mtd/
