From: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Subject: Re: could not mount a spi-flash on rootfs
Date: Thu, 3 Jul 2014 10:41:35 +0200
Message-ID: <CAMuHMdU-XBeubyEr-UbvZiz=UQysC7WYtEJ4TMwuww1x7LSBeg@mail.gmail.com>
References: <CAN=meTma1_cAHQ82S0VHemYDChJw_Orpc3K7-k9O3ggPqtsDuQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	"Shimoda, Yoshihiro" <yoshihiro.shimoda.uh-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
To: Cao Minh Hiep <hiepcm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAN=meTma1_cAHQ82S0VHemYDChJw_Orpc3K7-k9O3ggPqtsDuQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hi Hiep-san,

On Thu, Jul 3, 2014 at 7:09 AM, Cao Minh Hiep <hiepcm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> On 06/30/2014 04:21 PM, Geert Uytterhoeven wrote:
> > On Mon, Jun 30, 2014 at 4:29 AM, =E3=82=AB=E3=82=AA=E3=80=80=E3=83=9F=
=E3=83=B3=E3=80=80=E3=83=92=E3=82=A7=E3=83=83=E3=83=97 <cm-hiep@jinso.c=
o.jp> wrote:
> > > "EXT3-fs (mtdblock2): error: can't find ext3 filesystem on dev mt=
dblock2.
> > > EXT2-fs (mtdblock2): error: can't find an ext2 filesystem on dev
> > > mtdblock2.
> > > EXT4-fs (mtdblock2): VFS: Can't find ext4 filesystem
> > > FAT-fs (mtdblock2): bogus number of reserved sectors
> > > FAT-fs (mtdblock2): Can't find a valid FAT filesystem
> > > FAT-fs (mtdblock2): bogus number of reserved sectors
> > > FAT-fs (mtdblock2): Can't find a valid FAT filesystem
> >> mount: you must specify the filesystem type"
> > > root@linaro-nano:~# mount /dev/mtdblock2 /mnt/

> > Strange.
> >
> > Can you check that writing works using some other way, e.g. using d=
d?
>
> I have checked the writing works using other way (using dd command di=
rectly)
> as below:
>
> # uname -a
> Linux linaro-nano 3.10.31-ltsi-00002-g7bdf07f-dirty #1 Mon Jun 30 09:=
18:01
> JST 2014x
> # du -h 2.in
> 2.1M    2.in
>
> # dd if=3D2M.in of=3D/dev/mtdblock2 bs=3D1M count=3D2
> 2+0 records in
> 2+0 records out
> 2097152 bytes (2.1 MB) copied, 155.454 s, 13.5 kB/s
> root@linaro-nano:~# dd if=3D/dev/mtdblock2 of=3D2M.out bs=3D1M count=3D=
2
> 2+0 records in
> 2+0 records out
> 2097152 bytes (2.1 MB) copied, 83.3882 s, 25.1 kB/s
> root@linaro-nano:~# ls
> 2M.in    2M.out
> root@linaro-nano:~# md5sum 2M.in 2M.out
> bf90a4724c584901fae07749965208e3  2M.in
> bf90a4724c584901fae07749965208e3  2M.out

So writing works.

Then I guess you'll have to do more investigations:

  1. Clear /dev/mtdblock2:
         dd if=3D/dev/zero of=3D/dev/mtdblock2 bs=3D1M
  1. Create an ext3 file system on /dev/mtdblock2
  2. Create a file with the same size as mtdblock2:
         dd if=3D/dev/zero of=3Dfile bs=3Dsize count=3D1
  3. Create an ext3 file system on file
  4. Compare the ext3 file systems on /dev/mtdblock2 and file,
     using e.g. hd and diff -u, to find out what's different.

Once we know what the differences are, we can investigate the
failure mode.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-=
m68k.org

In personal conversations with technical people, I call myself a hacker=
=2E But
when I'm talking to journalists I just say "programmer" or something li=
ke that.
                                -- Linus Torvalds
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
