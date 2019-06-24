From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v2 00/28] drivers: Consolidate device lookup helpers
Date: Mon, 24 Jun 2019 05:23:48 +0200
Message-ID: <20190624032348.GA28919@kroah.com>
References: <1560534863-15115-1-git-send-email-suzuki.poulose@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Cc: Andrew Lunn <andrew@lunn.ch>, Shyam Sundar S K <shyam-sundar.s-k@amd.com>,
 rafael@kernel.org, Will Deacon <will.deacon@arm.com>,
 Ulf Hansson <ulf.hansson@linaro.org>, dri-devel@lists.freedesktop.org,
 Pavel Machek <pavel@ucw.cz>, Stefan Schmidt <stefan@datenfreihafen.org>,
 Wolfram Sang <wsa@the-dreams.de>, linux-acpi@vger.kernel.org,
 Doug Ledford <dledford@redhat.com>, Jiri Slaby <jslaby@suse.com>,
 Tomas Winkler <tomas.winkler@intel.com>, Dan Murphy <dmurphy@ti.com>,
 linux-usb@vger.kernel.org, Seung-Woo Kim <sw0312.kim@samsung.com>,
 linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
 Joe Perches <joe@perches.com>, linux-wpan@vger.kernel.org,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 David Airlie <airlied@linux.ie>, "Rafael J . Wysocki " <rjw@rjwysocki.net>,
 Thierry Reding <thierry.reding@gmail.com>,
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
 linu
To: Suzuki K Poulose <suzuki.poulose@arm.com>
Return-path: <dri-devel-bounces@lists.freedesktop.org>
Content-Disposition: inline
In-Reply-To: <1560534863-15115-1-git-send-email-suzuki.poulose@arm.com>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
List-Id: linux-spi.vger.kernel.org

T24gRnJpLCBKdW4gMTQsIDIwMTkgYXQgMDY6NTM6NTVQTSArMDEwMCwgU3V6dWtpIEsgUG91bG9z
ZSB3cm90ZToKPiBXZSBoYXZlIGRldmljZSBpdGVyYXRvcnMgdG8gZmluZCBhIHBhcnRpY3VsYXIg
ZGV2aWNlIG1hdGNoaW5nIGEgY3JpdGVyaWEKPiBmb3IgYSBnaXZlbiBidXMvY2xhc3MvZHJpdmVy
LiBpLmUsIHtidXMsY2xhc3MsZHJpdmVyfV9maW5kX2RldmljZSgpIEFQSXMuCj4gVGhlIG1hdGNo
aW5nIGNyaXRlcmlhIGlzIGEgZnVuY3Rpb24gcG9pbnRlciBmb3IgdGhlIEFQSXMuIE9mdGVuIHRo
ZSBsb29rdXAKPiBpcyBiYXNlZCBvbiBhIGdlbmVyaWMgcHJvcGVydHkgb2YgYSBkZXZpY2UgKGUu
ZywgbmFtZSwgZndub2RlLCBvZiBub2RlIHBvaW50ZXIKPiBvciBkZXZpY2UgdHlwZSkgcmF0aGVy
IHRoYW4gYSBkcml2ZXIgc3BlY2lmaWMgaW5mb3JtYXRpb24uIEhvd2V2ZXIsIGVhY2ggZHJpdmVy
Cj4gd3JpdGVzIHVwIGl0cyBvd24gIm1hdGNoIiBmdW5jdGlvbiwgc3BpbGxpbmcgdGhlIHNpbWls
YXIgbWF0Y2ggZnVuY3Rpb25zIGFsbAo+IG92ZXIgdGhlIGRyaXZlciBzdWJzeXN0ZW1zLgo+IAo+
IEFkZGl0aW9uYWxseSB0aGUgcHJvdG90eXBlIGZvciB0aGUgIm1hdGNoIiBmdW5jdGlvbnMgYWNj
ZXB0ZWQgYnkgdGhlIGFib3ZlIEFQSXMKPiBoYXZlIGEgbWludXRlIGRpZmZlcmVuY2Ugd2hpY2gg
cHJldmVudHMgdXMgb3RoZXJ3aXNlIHNoYXJpbmcgdGhlIG1hdGNoIGZ1bmN0aW9ucy4KPiBpLmUs
Cj4gCWludCAoKm1hdGNoKShzdHJ1Y3QgZGV2aWNlICpkZXYsIHZvaWQgKmRhdGEpIGZvciB7YnVz
L2RyaXZlcn1fZmluZF9kZXZpY2UoKQo+IAkgIHZzCj4gCWludCAoKm1hdGNoKShzdHJ1Y3QgZGV2
aWNlICpkZXYsIGNvbnN0IHZvaWQgKikgZm9yIGNsYXNzX2ZpbmRfZGV2aWNlKCkKPiAKPiBJZiB3
ZSBwcm9tb3RlIHRoZSBmb3JtZXIgdG8gYWNjZXB0IGEgImNvbnN0IHZvaWQqIiBwYXJhbWV0ZXIs
IHdlIGNvdWxkIHNoYXJlIG9uZQo+IHNpbmdsZSBtYXRjaCBmdW5jdGlvbiBmb3IgYWxsIHRoZSBo
ZWxwZXJzLiBUaGlzIHNlcmllcyBhY2hpZXZlcyB0aGUgZm9sbG93aW5nOgo+IAo+ICBhKSBbUGF0
Y2hlcyAwMy0wNV0gVW5pZnkgdGhlIHByb3RvdHlwZSBmb3IgIm1hdGNoIiBmdW5jdGlvbnMgYWNj
ZXB0ZWQgYnkgdGhlCj4gICAgICBkZXZpY2UgbG9va3VwIEFQSXMuCgpJJ3ZlIGFwcGxpZWQgdGhl
IGZpcnN0IDYgcGF0Y2hlcyBvZiB0aGlzIHNlcmllcyB0byBteSB0cmVlIG5vdy4gIExldCdzCnNl
ZSBob3cgdGhhdCBnb2VzLCBhbmQgdGhpcyBzaG91bGQgZ2l2ZSB5b3UgYSBtb3JlIHNvbGlkIGJh
c2UgdG8gcmVkbwp0aGUgcmVzdCBvZiB0aGUgc2VyaWVzIG9mZiBvZi4KCnRoYW5rcywKCmdyZWcg
ay1oCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmRyaS1k
ZXZlbCBtYWlsaW5nIGxpc3QKZHJpLWRldmVsQGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczov
L2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2RyaS1kZXZlbA==
