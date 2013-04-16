From: Sekhar Nori <nsekhar@ti.com>
Subject: Re: [PATCH v5 0/5] Patch enables support for m25p64 SPI flash support
 on da850-EVM.
Date: Tue, 16 Apr 2013 16:06:27 +0530
Message-ID: <516D29AB.8000004@ti.com>
References: <1364998150-5980-1-git-send-email-prakash.pm@ti.com>
 <A73F36158E33644199EB82C5EC81C7BC3EA4C560@DBDE01.ent.ti.com>
 <516BE92B.90002@ti.com> <20130416102041.CC5633E14C0@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: "davinci-linux-open-source@linux.davincidsp.com"
 <davinci-linux-open-source@linux.davincidsp.com>,
 "linux@arm.linux.org.uk" <linux@arm.linux.org.uk>,
 "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
 "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>,
 "rob.herring@calxeda.com" <rob.herring@calxeda.com>, "Manjunathappa,
 Prakash" <prakash.pm@ti.com>, "rob@landley.net" <rob@landley.net>,
 Olof Johansson <olof@lixom.net>, "spi-devel-general@lists.sourceforge.net"
 <spi-devel-general@lists.sourceforge.net>, "hs@denx.de" <hs@denx.de>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
To: Grant Likely <grant.likely@secretlab.ca>
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20130416102041.CC5633E14C0@localhost>
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

On 4/16/2013 3:50 PM, Grant Likely wrote:
> On Mon, 15 Apr 2013 17:18:59 +0530, Sekhar Nori <nsekhar@ti.com> wrote:
>> On 4/9/2013 11:14 AM, Manjunathappa, Prakash wrote:
>>> Hi Grant,
>>>
>>> On Wed, Apr 03, 2013 at 19:39:05, Manjunathappa, Prakash wrote:
>>>> Testing information:
>>>> da850-evm comes with partitions specified in DT blob.
>>>> Able to mount/umount and create/delete files on filesystem partition.
>>>>
>>>
>>> Could you please ack the driver(1/5) and documentation(2/5) changes so
>>> that Sekhar can merge the platform changes, he doesn't have any
>>> objection on this series.
>>> http://marc.info/?l=linux-doc&m=136489750130615&w=1
>>
>> I am planning to queue these patches for ARM-SoC today. Grant has not
>> acked these but 1/5 just fixes the binding name to not use wild cards
>> and 2/5 just documents existing bindings and is something that should
>> have been merge last merge window itself (when the bindings were
>> accepted). So, the patches pending on Grant's ack seem very low risk to
>> me and we are much delayed already to wait further.
> 
> For both of those patches:
> Acked-by: Grant Likely <grant.likely@secretlab.ca>

Thanks Grant. I sent my pull request already. CCing Olof to see if
adding your ack locally when he pulls is something he is open to.

Thanks,
Sekhar
