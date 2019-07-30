From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [RFC v1 0/3] *spi-mem: adding setup and callback function
Date: Tue, 30 Jul 2019 19:53:49 +0300
Message-ID: <2272f934-df83-bd6d-2aee-ac2d93799092@cogentembedded.com>
References: <20190729142504.188336-1-tmaimon77@gmail.com>
 <20190729172859.4374a2ad@collabora.com>
 <CAP6Zq1iPXDX_Gtz6ZWYm3JoHgHjdapotVLGw-Lq4tc2X-6eAug@mail.gmail.com>
 <20190730085438.6fe0480b@collabora.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: bbrezillon@kernel.org, richard@nod.at, tudor.ambarus@microchip.com,
 Schrempf Frieder <frieder.schrempf@kontron.de>, linux-spi@vger.kernel.org,
 broonie@kernel.org, linux-mtd@lists.infradead.org, miquel.raynal@bootlin.com
To: Boris Brezillon <boris.brezillon@collabora.com>,
 Tomer Maimon <tmaimon77@gmail.com>, vigneshr@ti.com
Return-path: <linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org>
In-Reply-To: <20190730085438.6fe0480b@collabora.com>
Content-Language: en-MW
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

On 07/30/2019 09:54 AM, Boris Brezillon wrote:

> Trimmed the recipient list a bit and used Frieder's new address.
> +Sergey

  TY. :-)

> On Mon, 29 Jul 2019 23:55:05 +0300
> Tomer Maimon <tmaimon77@gmail.com> wrote:
> 
>> Hi Boris,
>>
>> Thanks for the prompt reply,
>>
>>
>>
>> On Mon, 29 Jul 2019 at 18:29, Boris Brezillon <boris.brezillon@collabora.com>
>> wrote:
>>
>>> Hi Tomer,
>>>
>>> On Mon, 29 Jul 2019 17:25:01 +0300
>>> Tomer Maimon <tmaimon77@gmail.com> wrote:
>>>  
>>>> Lately we have working on Flash interface unit (FIU) SPI driver that
>>>> using spi-mem interface, Our FIU HW module support direct Flash Rd//Wr.
>>>>
>>>> In our SOC (32 bit dual core ARM) we have 3 FIU's that using memory  
>>> mapping as follow:  
>>>>
>>>> FIU0 - have 2 chip select and each one have 128MB memory mapping (total  
>>> 256MB memory mapping)  
>>>> FIU1 - have 4 chip select and each one have 128MB memory mapping (total  
>>> 512MB memory mapping)  
>>>> FIU2 - have 4 chip select and each one have 16MB memory mapping (total  
>>> 32MB memory mapping)  
>>>>
>>>> Totally 800MB memory mapping.
>>>>
>>>> When the FIU driver probe it don't know the size of each Flash that
>>>> connected to the FIU, so the entire memory mapping is allocated for each  
>>> FIU  
>>>> according the FIU device tree memory map parameters.  
>>>
>>> Do you need those mappings to be active to support simple reg accesses?
>>>  
>>>> It means, if we enable all three FIU's the drivers will try to allocate  
>>> totally 800MB.  
>>>>
>>>> In 32bit system it is problematic because the kernel have only 1GB
>>>> of memory allocation so the vmalloc cannot take 800MB.
>>>>
>>>> When implementing the FIU driver in the mtd/spi-nor we allocating memory  
>>> address only  
>>>> for detected Flash with exact size (usually we are not using 128MB  
>>> Flash), and in that case usually we allocating much less memory.  
>>>>
>>>> To solve this issue we needed to overcome two things:
>>>>
>>>> 1.    Get argument from the upper layer (spi-mem layer)
>>>> 2.    Calling the get argument function after SPI_NOR_SCAN function.  
>>> (the MTD Flash size filled in  SPI_NOR_SCAN function)
>>>
>>> That's clearly breaking the layering we've tried to restore with the
>>> spi-nor/spi-mem split, and I don't see why this is needed since we now
>>> have a way to create direct mappings dynamically (with the dirmap API).
>>> Have you tried implementing the dirmap hooks in your driver?  
>>
>>
>>  Sorry but I wasn't familiar with the direct mapping in the spi-mem, it
>> seems it needed to implemented in the m25p80 driver as well, am I correct?
> 
> There's this patch [1] floating around. IIRC, Sergey was waiting for
> the m25p80 -> spi-nor merge to send a v5.

   No, not really waiting for it. I was asked to recast the patch using
the managed device APIs, and I got sucked into my HyperFlash driver and
dropped the ball...

> Vignesh, any updates on that
> one? If you don't have time to work on that, maybe Sergey could send a
> v5.

   I can try recasting it RSN, if it's blocking some other stuff...

> [1]https://www.spinics.net/lists/linux-mtd/msg07358.html

MBR, Sergei

______________________________________________________
Linux MTD discussion mailing list
http://lists.infradead.org/mailman/listinfo/linux-mtd/
