From: =?UTF-8?B?44Kr44Kq44CA44Of44Oz44CA44OS44Kn44OD44OX?=
	<cm-hiep-HEF513clHfp3+QwDJ9on6Q@public.gmane.org>
Subject: Re: could not mount a spi-flash on rootfs
Date: Mon, 30 Jun 2014 11:29:24 +0900
Message-ID: <53B0CB84.6030001@jinso.co.jp>
References: <53AA941D.3000808@jinso.co.jp> <CAMuHMdWBf1+A9=8b1x+e0YcV3d=K_tBvqUeBXxvoHFy=QHcJxQ@mail.gmail.com>
Reply-To: cm-hiep-HEF513clHfp3+QwDJ9on6Q@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------070301060701040805030205"
Cc: linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	"Shimoda, Yoshihiro" <yoshihiro.shimoda.uh-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
To: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAMuHMdWBf1+A9=8b1x+e0YcV3d=K_tBvqUeBXxvoHFy=QHcJxQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

This is a multi-part message in MIME format.
--------------070301060701040805030205
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Geert-san

Thanks for your replying


>> "EXT3-fs (mtdblock2): error: can't find ext3 filesystem on dev mtdblock2.
>> EXT2-fs (mtdblock2): error: can't find an ext2 filesystem on dev mtdblock2.
>> EXT4-fs (mtdblock2): VFS: Can't find ext4 filesystem
>> FAT-fs (mtdblock2): bogus number of reserved sectors
>> FAT-fs (mtdblock2): Can't find a valid FAT filesystem
>> FAT-fs (mtdblock2): bogus number of reserved sectors
>> FAT-fs (mtdblock2): Can't find a valid FAT filesystem
>> mount: you must specify the filesystem type"
>> root@linaro-nano:~# mount /dev/mtdblock2 /mnt/
> Does it make a difference if you explicitly specify the file system type,
> by adding "-t ext3"?
I have tried to specify the system type by adding "-t ext3" or "-t ext4",
but it has no change anything.
I attached the qspi test logs file. Please see it.

>> I have enabled ext2,3,4 file systems when configuring the kernel.
>> and I saw that the qspi driver code is same with upstream version code that
>> be good.
>> maybe the problem related to mtd (m25p80.c) (?)
>> I attach the logs files when making a spi-flash partition and mount it on
>> rootfs.
> It looks like the file system wasn't written correctly to the device.
> Do you see anything suspicious in the kernel log (dmesg)?
No, I don't see anything suspicious in the kernel log. It is normally 
log for qspi.

> You mentioned you tested this on upstream-ltsi v3.10.31.
> Do you mean the above test, which failed?
yes, I do.
>> root@linaro-nano:~# fdisk /dev/mtdblock2
> [...]
>
>> root@linaro-nano:~# mkfs.ext3 /dev/mtdblock2
> BTW, why do you run fdisk on /dev/mtdblock2 first?
> According to your logs, you're running mkfs.ext3 on the raw /dev/mtdblock2
> afterwards, erasing your partition table again.
Thanks, I got it.


Best regards,
Hiep


--------------070301060701040805030205
Content-Type: text/plain; charset=UTF-8;
 name="qspi-test-log.txt"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="qspi-test-log.txt"

cmVuZXNhc19zcGkgcXNwaS4wOiBtYXN0ZXIgaXMgdW5xdWV1ZWQsIHRoaXMgaXMgZGVwcmVj
YXRlZAptMjVwODAgc3BpMC4wOiBzMjVmbDUxMnMgKDY1NTM2IEtieXRlcykKQ3JlYXRpbmcg
MyBNVEQgcGFydGl0aW9ucyBvbiAibTI1cDgwIjoKMHgwMDAwMDAwMDAwMDAtMHgwMDAwMDAw
NDAwMDAgOiAibG9hZGVyIgoweDAwMDAwMDA0MDAwMC0weDAwMDAwMDQ0MDAwMCA6ICJ1c2Vy
IgoweDAwMDAwMDQ0MDAwMC0weDAwMDAwNDAwMDAwMCA6ICJmbGFzaCIKcmVuZXNhc19zcGkg
cXNwaS4wOiBwcm9iZWQKCgojIG1rZnMuZXh0MyAtdCBleHQzIC9kZXYvbXRkYmxvY2syICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCm1rZTJmcyAxLjQyLjUgKDI5LUp1
bC0yMDEyKQpGaWxlc3lzdGVtIGxhYmVsPQpPUyB0eXBlOiBMaW51eApCbG9jayBzaXplPTEw
MjQgKGxvZz0wKQpGcmFnbWVudCBzaXplPTEwMjQgKGxvZz0wKQpTdHJpZGU9MCBibG9ja3Ms
IFN0cmlwZSB3aWR0aD0wIGJsb2NrcwoxNTI5NiBpbm9kZXMsIDYxMTg0IGJsb2NrcwozMDU5
IGJsb2NrcyAoNS4wMCUpIHJlc2VydmVkIGZvciB0aGUgc3VwZXIgdXNlcgpGaXJzdCBkYXRh
IGJsb2NrPTEKTWF4aW11bSBmaWxlc3lzdGVtIGJsb2Nrcz02MjY1MjQxNgo4IGJsb2NrIGdy
b3Vwcwo4MTkyIGJsb2NrcyBwZXIgZ3JvdXAsIDgxOTIgZnJhZ21lbnRzIHBlciBncm91cAox
OTEyIGlub2RlcyBwZXIgZ3JvdXAKU3VwZXJibG9jayBiYWNrdXBzIHN0b3JlZCBvbiBibG9j
a3M6IAogICAgICAgIDgxOTMsIDI0NTc3LCA0MDk2MSwgNTczNDUKCkFsbG9jYXRpbmcgZ3Jv
dXAgdGFibGVzOiBkb25lICAgICAgICAgICAgICAgICAgICAgICAgICAgIApXcml0aW5nIGlu
b2RlIHRhYmxlczogZG9uZSAgICAgICAgICAgICAgICAgICAgICAgICAgICAKQ3JlYXRpbmcg
am91cm5hbCAoNDA5NiBibG9ja3MpOiBkb25lCldyaXRpbmcgc3VwZXJibG9ja3MgYW5kIGZp
bGVzeXN0ZW0gYWNjb3VudGluZyBpbmZvcm1hdGlvbjogZG9uZQoKcm9vdEBsaW5hcm8tbmFu
bzp+IyBtb3VudCAvZGV2L210ZGJsb2NrMiAvbW50LwpFWFQzLWZzIChtdGRibG9jazIpOiBl
cnJvcjogY2FuJ3QgZmluZCBleHQzIGZpbGVzeXN0ZW0gb24gZGV2IG10ZGJsb2NrMi4KRVhU
NC1mcyAobXRkYmxvY2syKTogVkZTOiBDYW4ndCBmaW5kIGV4dDQgZmlsZXN5c3RlbQpFWFQ0
LWZzIChtdGRibG9jazIpOiBWRlM6IENhbid0IGZpbmQgZXh0NCBmaWxlc3lzdGVtCkZBVC1m
cyAobXRkYmxvY2syKTogYm9ndXMgbnVtYmVyIG9mIHJlc2VydmVkIHNlY3RvcnMKRkFULWZz
IChtdGRibG9jazIpOiBDYW4ndCBmaW5kIGEgdmFsaWQgRkFUIGZpbGVzeXN0ZW0KRkFULWZz
IChtdGRibG9jazIpOiBib2d1cyBudW1iZXIgb2YgcmVzZXJ2ZWQgc2VjdG9ycwpGQVQtZnMg
KG10ZGJsb2NrMik6IENhbid0IGZpbmQgYSB2YWxpZCBGQVQgZmlsZXN5c3RlbQptb3VudDog
eW91IG11c3Qgc3BlY2lmeSB0aGUgZmlsZXN5c3RlbSB0eXBlCnJvb3RAbGluYXJvLW5hbm86
fiMgbW91bnQgLXQgZXh0MyAvZGV2L210ZGJsb2NrMiAvbW50LyAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAKRVhUMy1mcyAobXRkYmxvY2syKTogZXJyb3I6IGNhbid0IGZp
bmQgZXh0MyBmaWxlc3lzdGVtIG9uIGRldiBtdGRibG9jazIuCm1vdW50OiB3cm9uZyBmcyB0
eXBlLCBiYWQgb3B0aW9uLCBiYWQgc3VwZXJibG9jayBvbiAvZGV2L210ZGJsb2NrMiwKICAg
ICAgIG1pc3NpbmcgY29kZXBhZ2Ugb3IgaGVscGVyIHByb2dyYW0sIG9yIG90aGVyIGVycm9y
CiAgICAgICBJbiBzb21lIGNhc2VzIHVzZWZ1bCBpbmZvIGlzIGZvdW5kIGluIHN5c2xvZyAt
IHRyeQogICAgICAgZG1lc2cgfCB0YWlsICBvciBzbwoKCgoKIyBta2ZzLmV4dDQgLXQgZXh0
NCAvZGV2L210ZGJsb2NrMiAKbWtlMmZzIDEuNDIuNSAoMjktSnVsLTIwMTIpCkZpbGVzeXN0
ZW0gbGFiZWw9Ck9TIHR5cGU6IExpbnV4CkJsb2NrIHNpemU9MTAyNCAobG9nPTApCkZyYWdt
ZW50IHNpemU9MTAyNCAobG9nPTApClN0cmlkZT0wIGJsb2NrcywgU3RyaXBlIHdpZHRoPTAg
YmxvY2tzCjE1Mjk2IGlub2RlcywgNjExODQgYmxvY2tzCjMwNTkgYmxvY2tzICg1LjAwJSkg
cmVzZXJ2ZWQgZm9yIHRoZSBzdXBlciB1c2VyCkZpcnN0IGRhdGEgYmxvY2s9MQpNYXhpbXVt
IGZpbGVzeXN0ZW0gYmxvY2tzPTYyNjUyNDE2CjggYmxvY2sgZ3JvdXBzCjgxOTIgYmxvY2tz
IHBlciBncm91cCwgODE5MiBmcmFnbWVudHMgcGVyIGdyb3VwCjE5MTIgaW5vZGVzIHBlciBn
cm91cApTdXBlcmJsb2NrIGJhY2t1cHMgc3RvcmVkIG9uIGJsb2NrczogCiAgICAgICAgODE5
MywgMjQ1NzcsIDQwOTYxLCA1NzM0NQoKQWxsb2NhdGluZyBncm91cCB0YWJsZXM6IGRvbmUg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgCldyaXRpbmcgaW5vZGUgdGFibGVzOiBkb25l
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIApDcmVhdGluZyBqb3VybmFsICg0MDk2IGJs
b2Nrcyk6IGRvbmUKV3JpdGluZyBzdXBlcmJsb2NrcyBhbmQgZmlsZXN5c3RlbSBhY2NvdW50
aW5nIGluZm9ybWF0aW9uOiAgICAKCgpkb25lCgpyb290QGxpbmFyby1uYW5vOn4jIApyb290
QGxpbmFyby1uYW5vOn4jIApyb290QGxpbmFyby1uYW5vOn4jIApyb290QGxpbmFyby1uYW5v
On4jIG1vdW50IC10IGV4dDQgL2Rldi9tdGRibG9jazIgL21udC8KRVhUNC1mcyAobXRkYmxv
Y2syKTogVkZTOiBDYW4ndCBmaW5kIGV4dDQgZmlsZXN5c3RlbQptb3VudDogd3JvbmcgZnMg
dHlwZSwgYmFkIG9wdGlvbiwgYmFkIHN1cGVyYmxvY2sgb24gL2Rldi9tdGRibG9jazIsCiAg
ICAgICBtaXNzaW5nIGNvZGVwYWdlIG9yIGhlbHBlciBwcm9ncmFtLCBvciBvdGhlciBlcnJv
cgogICAgICAgSW4gc29tZSBjYXNlcyB1c2VmdWwgaW5mbyBpcyBmb3VuZCBpbiBzeXNsb2cg
LSB0cnkKICAgICAgIGRtZXNnIHwgdGFpbCAgb3Igc28KCnJvb3RAbGluYXJvLW5hbm86fiMg
bW91bnQgL2Rldi9tdGRibG9jazIgL21udC8KRVhUMy1mcyAobXRkYmxvY2syKTogZXJyb3I6
IGNhbid0IGZpbmQgZXh0MyBmaWxlc3lzdGVtIG9uIGRldiBtdGRibG9jazIuCkVYVDQtZnMg
KG10ZGJsb2NrMik6IFZGUzogQ2FuJ3QgZmluZCBleHQ0IGZpbGVzeXN0ZW0KRVhUNC1mcyAo
bXRkYmxvY2syKTogVkZTOiBDYW4ndCBmaW5kIGV4dDQgZmlsZXN5c3RlbQpGQVQtZnMgKG10
ZGJsb2NrMik6IGJvZ3VzIG51bWJlciBvZiByZXNlcnZlZCBzZWN0b3JzCkZBVC1mcyAobXRk
YmxvY2syKTogQ2FuJ3QgZmluZCBhIHZhbGlkIEZBVCBmaWxlc3lzdGVtCkZBVC1mcyAobXRk
YmxvY2syKTogYm9ndXMgbnVtYmVyIG9mIHJlc2VydmVkIHNlY3RvcnMKRkFULWZzIChtdGRi
bG9jazIpOiBDYW4ndCBmaW5kIGEgdmFsaWQgRkFUIGZpbGVzeXN0ZW0KbW91bnQ6IHlvdSBt
dXN0IHNwZWNpZnkgdGhlIGZpbGVzeXN0ZW0gdHlwZQoK
--------------070301060701040805030205--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
