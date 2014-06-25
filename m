From: =?UTF-8?B?44Kr44Kq44CA44Of44Oz44CA44OS44Kn44OD44OX?=
	<cm-hiep-HEF513clHfp3+QwDJ9on6Q@public.gmane.org>
Subject: could not mount a spi-flash on rootfs
Date: Wed, 25 Jun 2014 18:19:25 +0900
Message-ID: <53AA941D.3000808@jinso.co.jp>
Reply-To: cm-hiep-HEF513clHfp3+QwDJ9on6Q@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------070904030301090407000008"
To: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	"Shimoda, Yoshihiro" <yoshihiro.shimoda.uh-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

This is a multi-part message in MIME format.
--------------070904030301090407000008
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

  Hi,

I am working on Lager board from Renesas, We have tested qspi driver on 
upstream-ltsi v3.10.31、

(http://ltsi.linuxfoundation.org/sites/ltsi/files/patch-3.10.31-ltsi.gz)

When mounting /dev/mtdblock2 on /mnt/, there are some messages as a below:

"EXT3-fs (mtdblock2): error: can't find ext3 filesystem on dev mtdblock2.
EXT2-fs (mtdblock2): error: can't find an ext2 filesystem on dev mtdblock2.
EXT4-fs (mtdblock2): VFS: Can't find ext4 filesystem
FAT-fs (mtdblock2): bogus number of reserved sectors
FAT-fs (mtdblock2): Can't find a valid FAT filesystem
FAT-fs (mtdblock2): bogus number of reserved sectors
FAT-fs (mtdblock2): Can't find a valid FAT filesystem
mount: you must specify the filesystem type"

I have enabled ext2,3,4 file systems when configuring the kernel.
and I saw that the qspi driver code is same with upstream version code 
that be good.
maybe the problem related to mtd (m25p80.c) (?)
I attach the logs files when making a spi-flash partition and mount it 
on rootfs.

Best regards,
Cao Minh Hiep


--------------070904030301090407000008
Content-Type: text/plain; charset=UTF-8;
 name="qspi-make-fdisk-partition-mount-logs.txt"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="qspi-make-fdisk-partition-mount-logs.txt"

cm9vdEBsaW5hcm8tbmFubzp+IyBmZGlzayAvZGV2L210ZGJsb2NrMiAKRGV2aWNlIGNvbnRh
aW5zIG5laXRoZXIgYSB2YWxpZCBET1MgcGFydGl0aW9uIHRhYmxlLCBub3IgU3VuLCBTR0kg
b3IgT1NGIGRpc2tsYWJlbApCdWlsZGluZyBhIG5ldyBET1MgZGlza2xhYmVsIHdpdGggZGlz
ayBpZGVudGlmaWVyIDB4Yjg3MTEwMjUuCkNoYW5nZXMgd2lsbCByZW1haW4gaW4gbWVtb3J5
IG9ubHksIHVudGlsIHlvdSBkZWNpZGUgdG8gd3JpdGUgdGhlbS4KQWZ0ZXIgdGhhdCwgb2Yg
Y291cnNlLCB0aGUgcHJldmlvdXMgY29udGVudCB3b24ndCBiZSByZWNvdmVyYWJsZS4KCldh
cm5pbmc6IGludmFsaWQgZmxhZyAweDAwMDAgb2YgcGFydGl0aW9uIHRhYmxlIDQgd2lsbCBi
ZSBjb3JyZWN0ZWQgYnkgdyhyaXRlKQoKQ29tbWFuZCAobSBmb3IgaGVscCk6IG4KUGFydGl0
aW9uIHR5cGU6CiAgIHAgICBwcmltYXJ5ICgwIHByaW1hcnksIDAgZXh0ZW5kZWQsIDQgZnJl
ZSkKICAgZSAgIGV4dGVuZGVkClNlbGVjdCAoZGVmYXVsdCBwKTogClVzaW5nIGRlZmF1bHQg
cmVzcG9uc2UgcApQYXJ0aXRpb24gbnVtYmVyICgxLTQsIGRlZmF1bHQgMSk6IApVc2luZyBk
ZWZhdWx0IHZhbHVlIDEKRmlyc3Qgc2VjdG9yICgyMDQ4LTEyMjM2NywgZGVmYXVsdCAyMDQ4
KTogClVzaW5nIGRlZmF1bHQgdmFsdWUgMjA0OApMYXN0IHNlY3RvciwgK3NlY3RvcnMgb3Ig
K3NpemV7SyxNLEd9ICgyMDQ4LTEyMjM2NywgZGVmYXVsdCAxMjIzNjcpOiAKVXNpbmcgZGVm
YXVsdCB2YWx1ZSAxMjIzNjcKCkNvbW1hbmQgKG0gZm9yIGhlbHApOiB0ClNlbGVjdGVkIHBh
cnRpdGlvbiAxCkhleCBjb2RlICh0eXBlIEwgdG8gbGlzdCBjb2Rlcyk6IDgzCgpDb21tYW5k
IChtIGZvciBoZWxwKTogdwpUaGUgcGFydGl0aW9uIHRhYmxlIGhhcyBiZWVuIGFsdGVyZWQh
CgpDYWxsaW5nIGlvY3RsKCkgdG8gcmUtcmVhZCBwYXJ0aXRpb24gdGFibGUuCgpXQVJOSU5H
OiBSZS1yZWFkaW5nIHRoZSBwYXJ0aXRpb24gdGFibGUgZmFpbGVkIHdpdGggZXJyb3IgMjI6
IEludmFsaWQgYXJndW1lbnQuClRoZSBrZXJuZWwgc3RpbGwgdXNlcyB0aGUgb2xkIHRhYmxl
LiBUaGUgbmV3IHRhYmxlIHdpbGwgYmUgdXNlZCBhdAp0aGUgbmV4dCByZWJvb3Qgb3IgYWZ0
ZXIgeW91IHJ1biBwYXJ0cHJvYmUoOCkgb3Iga3BhcnR4KDgpClN5bmNpbmcgZGlza3MuCnJv
b3RAbGluYXJvLW5hbm86fiMgbWtmcy5leHQzIC9kZXYvbXRkYmxvY2syIApta2UyZnMgMS40
Mi41ICgyOS1KdWwtMjAxMikKRmlsZXN5c3RlbSBsYWJlbD0KT1MgdHlwZTogTGludXgKQmxv
Y2sgc2l6ZT0xMDI0IChsb2c9MCkKRnJhZ21lbnQgc2l6ZT0xMDI0IChsb2c9MCkKU3RyaWRl
PTAgYmxvY2tzLCBTdHJpcGUgd2lkdGg9MCBibG9ja3MKMTUyOTYgaW5vZGVzLCA2MTE4NCBi
bG9ja3MKMzA1OSBibG9ja3MgKDUuMDAlKSByZXNlcnZlZCBmb3IgdGhlIHN1cGVyIHVzZXIK
Rmlyc3QgZGF0YSBibG9jaz0xCk1heGltdW0gZmlsZXN5c3RlbSBibG9ja3M9NjI2NTI0MTYK
OCBibG9jayBncm91cHMKODE5MiBibG9ja3MgcGVyIGdyb3VwLCA4MTkyIGZyYWdtZW50cyBw
ZXIgZ3JvdXAKMTkxMiBpbm9kZXMgcGVyIGdyb3VwClN1cGVyYmxvY2sgYmFja3VwcyBzdG9y
ZWQgb24gYmxvY2tzOiAKICAgICAgICA4MTkzLCAyNDU3NywgNDA5NjEsIDU3MzQ1CgpBbGxv
Y2F0aW5nIGdyb3VwIHRhYmxlczogZG9uZSAgICAgICAgICAgICAgICAgICAgICAgICAgICAK
V3JpdGluZyBpbm9kZSB0YWJsZXM6IGRvbmUgICAgICAgICAgICAgICAgICAgICAgICAgICAg
CgpDcmVhdGluZyBqb3VybmFsICg0MDk2IGJsb2Nrcyk6IGRvbmUKV3JpdGluZyBzdXBlcmJs
b2NrcyBhbmQgZmlsZXN5c3RlbSBhY2NvdW50aW5nIGluZm9ybWF0aW9uOiAgICAKCmRvbmUK
CnJvb3RAbGluYXJvLW5hbm86fiMgCnJvb3RAbGluYXJvLW5hbm86fiMgbW91bnQgL2Rldi9t
dGRibG9jazIgL21udC8KRVhUMy1mcyAobXRkYmxvY2syKTogZXJyb3I6IGNhbid0IGZpbmQg
ZXh0MyBmaWxlc3lzdGVtIG9uIGRldiBtdGRibG9jazIuCkVYVDItZnMgKG10ZGJsb2NrMik6
IGVycm9yOiBjYW4ndCBmaW5kIGFuIGV4dDIgZmlsZXN5c3RlbSBvbiBkZXYgbXRkYmxvY2sy
LgpFWFQ0LWZzIChtdGRibG9jazIpOiBWRlM6IENhbid0IGZpbmQgZXh0NCBmaWxlc3lzdGVt
CkZBVC1mcyAobXRkYmxvY2syKTogYm9ndXMgbnVtYmVyIG9mIHJlc2VydmVkIHNlY3RvcnMK
RkFULWZzIChtdGRibG9jazIpOiBDYW4ndCBmaW5kIGEgdmFsaWQgRkFUIGZpbGVzeXN0ZW0K
RkFULWZzIChtdGRibG9jazIpOiBib2d1cyBudW1iZXIgb2YgcmVzZXJ2ZWQgc2VjdG9ycwpG
QVQtZnMgKG10ZGJsb2NrMik6IENhbid0IGZpbmQgYSB2YWxpZCBGQVQgZmlsZXN5c3RlbQpt
b3VudDogeW91IG11c3Qgc3BlY2lmeSB0aGUgZmlsZXN5c3RlbSB0eXBlCgo=
--------------070904030301090407000008--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
