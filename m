From: =?UTF-8?B?44Kr44Kq44CA44Of44Oz44CA44OS44Kn44OD44OX?=
	<cm-hiep-HEF513clHfp3+QwDJ9on6Q@public.gmane.org>
Subject: Re: could not mount a spi-flash on rootfs
Date: Wed, 02 Jul 2014 15:01:12 +0900
Message-ID: <53B3A028.7020903@jinso.co.jp>
References: <53AA941D.3000808@jinso.co.jp>	<CAMuHMdWBf1+A9=8b1x+e0YcV3d=K_tBvqUeBXxvoHFy=QHcJxQ@mail.gmail.com>	<53B0CB84.6030001@jinso.co.jp> <CAMuHMdXnLG==TmZCLd=tZ0C1PPurjWkbE=ysCFCOgVK+5UCJnw@mail.gmail.com>
Reply-To: cm-hiep-HEF513clHfp3+QwDJ9on6Q@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	"Shimoda, Yoshihiro" <yoshihiro.shimoda.uh-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
To: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAMuHMdXnLG==TmZCLd=tZ0C1PPurjWkbE=ysCFCOgVK+5UCJnw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hi Geert-san

On 06/30/2014 04:21 PM, Geert Uytterhoeven wrote:
> Hi Hiep-san,
>
> On Mon, Jun 30, 2014 at 4:29 AM, =E3=82=AB=E3=82=AA=E3=80=80=E3=83=9F=
=E3=83=B3=E3=80=80=E3=83=92=E3=82=A7=E3=83=83=E3=83=97 <cm-hiep@jinso.c=
o.jp> wrote:
>>>> "EXT3-fs (mtdblock2): error: can't find ext3 filesystem on dev mtd=
block2.
>>>> EXT2-fs (mtdblock2): error: can't find an ext2 filesystem on dev
>>>> mtdblock2.
>>>> EXT4-fs (mtdblock2): VFS: Can't find ext4 filesystem
>>>> FAT-fs (mtdblock2): bogus number of reserved sectors
>>>> FAT-fs (mtdblock2): Can't find a valid FAT filesystem
>>>> FAT-fs (mtdblock2): bogus number of reserved sectors
>>>> FAT-fs (mtdblock2): Can't find a valid FAT filesystem
>>>> mount: you must specify the filesystem type"
>>>> root@linaro-nano:~# mount /dev/mtdblock2 /mnt/
>>> Does it make a difference if you explicitly specify the file system=
 type,
>>> by adding "-t ext3"?
>> I have tried to specify the system type by adding "-t ext3" or "-t e=
xt4",
>> but it has no change anything.
>> I attached the qspi test logs file. Please see it.
> "renesas_spi qspi.0: master is unqueued, this is deprecated"
>
> So this is indeed a very old version of the rspi driver.
> Which 3.10.31-ltsi are you using? The one from renesas-backports?
The source code is link below:
http://ltsi.linuxfoundation.org/sites/ltsi/files/patch-3.10.31-ltsi.gz
This qspi is added on rspi driver together that i am using. I think tha=
t=20
It was back-ported from a upstream version. I think this message does=20
not causing of the problem.
>>>> I have enabled ext2,3,4 file systems when configuring the kernel.
>>>> and I saw that the qspi driver code is same with upstream version =
code
>>>> that
>>>> be good.
>>>> maybe the problem related to mtd (m25p80.c) (?)
>>>> I attach the logs files when making a spi-flash partition and moun=
t it on
>>>> rootfs.
>>> It looks like the file system wasn't written correctly to the devic=
e.
>>> Do you see anything suspicious in the kernel log (dmesg)?
>> No, I don't see anything suspicious in the kernel log. It is normall=
y log
>> for qspi.
> Strange.
>
> Can you check that writing works using some other way, e.g. using dd?
I have checked the writing works using other way (using dd command=20
directly) as below:

# uname -a
Linux linaro-nano 3.10.31-ltsi-00002-g7bdf07f-dirty #1 Mon Jun 30=20
09:18:01 JST 2014x
# du -h 2.in
2.1M    2.in

# dd if=3D2M.in of=3D/dev/mtdblock2 bs=3D1M count=3D2
2+0 records in
2+0 records out
2097152 bytes (2.1 MB) copied, 155.454 s, 13.5 kB/s
root@linaro-nano:~# dd if=3D/dev/mtdblock2 of=3D2M.out bs=3D1M count=3D=
2
2+0 records in
2+0 records out
2097152 bytes (2.1 MB) copied, 83.3882 s, 25.1 kB/s
root@linaro-nano:~# ls
2M.in    2M.out
root@linaro-nano:~# md5sum 2M.in 2M.out
bf90a4724c584901fae07749965208e3  2M.in
bf90a4724c584901fae07749965208e3  2M.out

Best regards,
Hiep
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
