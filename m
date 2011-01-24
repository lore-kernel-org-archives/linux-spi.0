From: Alexis RODET <alexis.rodet@bvs-tech.com>
Subject: Re: [PATCH 0/1] Renaming 'struct flash_platform_data' into 'struct
	spi_flash_platform_data' in include/linux/spi/flash.h
Date: Mon, 24 Jan 2011 12:37:22 +0100
Message-ID: <4D3D6472.8030505@bvs-tech.com>
References: <327178.68946.qm@web180303.mail.gq1.yahoo.com>
	<4CEB89C6.3080603@bvs-tech.com>
	<20101123093643.GC6156@jasper.tkos.co.il>
	<4CEB8C39.1060801@bvs-tech.com>
	<20101123094414.GD6156@jasper.tkos.co.il>
	<4CEB8F7C.6070102@bvs-tech.com>
	<20110121192819.GA32112@angua.secretlab.ca>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------060206040404020506020106"
Cc: David Brownell <david-b@pacbell.net>,
	spi-devel-general@lists.sourceforge.net,
	Baruch Siach <baruch@tkos.co.il>, linux-mtd@lists.infradead.org,
	David Woodhouse <dwmw2@infradead.org>
To: Grant Likely <grant.likely@secretlab.ca>
Return-path: <linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org>
In-Reply-To: <20110121192819.GA32112@angua.secretlab.ca>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-mtd>,
	<mailto:linux-mtd-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mtd/>
List-Post: <mailto:linux-mtd@lists.infradead.org>
List-Help: <mailto:linux-mtd-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-mtd>,
	<mailto:linux-mtd-request@lists.infradead.org?subject=subscribe>
Sender: linux-mtd-bounces@lists.infradead.org
Errors-To: linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org
List-Id: linux-spi.vger.kernel.org

This is a multi-part message in MIME format.
--------------060206040404020506020106
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hello Grant,

On 21/01/2011 20:28, Grant Likely wrote :
> Hi Alexis,
>
> Patch doesn't apply.  Looks like it's whitespace damaged (tabs
> converted to spaces).  Did you try to cut & paste it?  git send-email
> is a more reliable way to post patches.
Yes I did, sorry I hadn't installed git-send-email.
OK I'll do this way.
Get my patch in next e-mail.
> Also, for a change as far-reaching as this you should do it in two
> stages; rename the structure, but leave a #define to the old name so
> that conflicts aren't generated in linux-next.  Then remove the
> #define after the change makes it into Linus' tree.
And I keep changing all source code that use this structure, don't I ?
>> Here is the command line used for doing this:
>> find . \( -name .git -prune -false -o -path ./include/linux/spi/flash.h -o \( -name \*.c -execdir grep -q '#include <linux/spi/flash.h>' \{\} \; \) \) -execdir sed -i -e 's/struct flash_platform_data/struct spi_flash_platform_data/' \{\} \+ -execdir git add \{\} \+ -print
> This looks to me like it will miss any files that include
> linux/spi/flash.h indirectly (ie, if they include a header that
> includes linux/spi/flash.h).  A simple 'git grep flash_platform_data'
> could very well be sufficient for finding the call sites.
Yes, I knew this might be a problem.
I checked this and this doesn't happen:
There is no ".h" file that include linux/spi/flash.h so their can't be indirect use.
I checked also any ".h" file that have 'struct flash_platform_data' and I found:
./arch/arm/mach-ixp2000/include/mach/platform.h
./arch/arm/mach-sa1100/generic.h
./arch/arm/include/asm/mach/flash.h
that are all related in source code to the last one.

After my patch, the only files that have struct flash_platform_data without #include <asm/mach/flash.h> are the 3 .h files above and ./drivers/mtd/onenand/generic.c inside a comment:
29: * with the name "onenand" used to take struct flash_platform_data.

> That being said, is it really worth making this change?  What is your
> motivation?  There isn't actually anything spi-specific in the
> flash_platform_data structure.
The main problem is there are 2 different struct flash_platform_data
1 in include/linux/spi/flash.h for SPI flash devices that work with SPI API (also through MTD).
1 in arm/include/asm/mach/flash.h for other mtd flash devices (NOR, NAND...) that work with MTD API.

The one in SPI is more recent and less used in source code, so this one should not have got the same name and the work is easier.

My motivation is I have a machine with both SPI and NOR/NAND that need both structures and ".h" files conflicts.

Alexis


--------------060206040404020506020106
Content-Type: text/x-vcard; charset=utf-8;
 name="alexis_rodet.vcf"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="alexis_rodet.vcf"

YmVnaW46dmNhcmQNCmZuOkFsZXhpcyBST0RFVA0KbjpST0RFVDtBbGV4aXMNCm9yZzpCcmFp
biBWaXNpb24gU3lzdGVtcw0KYWRyOjs7MzIgcnVlIGR1IEphdmVsb3Q7UEFSSVM7Ozc1MDEz
O0ZSQU5DRQ0KZW1haWw7aW50ZXJuZXQ6YWxleGlzLnJvZGV0QGJ2cy10ZWNoLmNvbQ0KdGl0
bGU6SGFyZHdhcmUgRW5naW5lZXINCnRlbDt3b3JrOiszMyA5IDUzIDkyIDE0IDQxDQp0ZWw7
ZmF4OiszMyA5IDU4IDkyIDE0IDQxDQp4LW1vemlsbGEtaHRtbDpGQUxTRQ0KdXJsOmh0dHA6
Ly93d3cuYnZzLXRlY2guY29tDQp2ZXJzaW9uOjIuMQ0KZW5kOnZjYXJkDQoNCg==
--------------060206040404020506020106
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

______________________________________________________
Linux MTD discussion mailing list
http://lists.infradead.org/mailman/listinfo/linux-mtd/

--------------060206040404020506020106--
